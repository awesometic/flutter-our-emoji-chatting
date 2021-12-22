import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

import '../../../main.dart';
import '../../repository/service/repository_service.dart';
import '../../utility/auth_const.dart' show AuthType;
import '../model/local_user.dart';
import 'auth_service.dart';

class AuthServiceImpl implements AuthService {
  final _repository = getIt<RepositoryService>();
  final _currentUser = BehaviorSubject<LocalUser>();

  @override
  void setCurrentUser(LocalUser user) => _currentUser.sink.add(user);

  @override
  LocalUser getCurrentUser() {
    return _currentUser.value;
  }

  @override
  Future<bool> isUserSignedIn() async {
    return GoogleSignIn().isSignedIn();
  }

  @override
  Future<LocalUser> getCurrentLocalUser() async {
    var prefs = await SharedPreferences.getInstance();
    LocalUser user;
    var id = prefs.getString('id');
    var name = prefs.getString('name');
    var avatar = prefs.getString('avatar');
    var aboutMe = prefs.getString('aboutMe');
    var oppositeUserId = prefs.getString('oppositeUserId') ?? '';

    if (id != null) {
      user = LocalUser(
          id: id,
          name: name,
          avatar: avatar,
          aboutMe: aboutMe,
          oppositeUserId: [oppositeUserId]);
    } else {
      // If the user does not exist, return a dummy user
      user = LocalUser(
          id: '', name: '', avatar: '', aboutMe: '', oppositeUserId: []);
    }
    return user;
  }

  @override
  void saveUserLocally(LocalUser user) async {
    final _prefs = await SharedPreferences.getInstance();

    if (user.id != null) {
      _prefs.setString('id', user.id!);
      _prefs.setString('name', user.name ?? '');
      _prefs.setString('avatar', user.avatar ?? '');
      _prefs.setString('aboutMe', user.aboutMe ?? '');

      // TODO: Manage the oppositeUserId separately
      // _prefs.setString('oppositeUserId', user.oppositeUserId[0] ?? '');
    }
  }

  @override
  Future<bool> userSignIn(AuthType type) async {
    UserCredential userCredential;
    User? firebaseUser;

    switch (type) {
      case AuthType.google:
        var googleUser = await GoogleSignIn().signIn();
        if (googleUser != null) {
          var googleAuth =
              await googleUser.authentication.catchError((error) => null);

          final credential = GoogleAuthProvider.credential(
              accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

          userCredential = await _repository.signInWithCredential(credential);
          firebaseUser = userCredential.user;
        }
        break;
      case AuthType.apple:
        const charset =
            '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
        final random = Random.secure();
        final rawNonce =
            List.generate(32, (_) => charset[random.nextInt(charset.length)])
                .join();
        final bytes = utf8.encode(rawNonce);
        final digest = sha256.convert(bytes);
        final nonce = digest.toString();

        final appleCredential = await SignInWithApple.getAppleIDCredential(
            scopes: [
              AppleIDAuthorizationScopes.email,
              AppleIDAuthorizationScopes.fullName,
            ],
            nonce: nonce,
            webAuthenticationOptions: WebAuthenticationOptions(
                clientId: "net.awesometic.ourEmojiChatting.signIn",
                redirectUri: Uri.parse(
                    "https://api-test.awesometic.net/our-emoji-chatting/callbacks/sign_in_with_apple")));

        if (appleCredential != null) {
          final credential = OAuthProvider("apple.com").credential(
              accessToken: appleCredential.authorizationCode,
              idToken: appleCredential.identityToken,
              rawNonce: rawNonce);

          userCredential = await _repository.signInWithCredential(credential);
          firebaseUser = userCredential.user;
        }
        break;
      case AuthType.github:
        firebaseUser = await FirebaseAuthOAuth().openSignInFlow("github.com", [
          "read:user",
          "user:email",
        ]);

        break;
    }

    if (firebaseUser != null) {
      var user = await _repository.getUser(firebaseUser.uid);

      // TODO: This condition is always false. Need to implement signing-in process
      if (user == null) {
        user = LocalUser(
            id: firebaseUser.uid,
            name: firebaseUser.displayName,
            avatar: firebaseUser.photoURL);

        await _repository.registerUser(user);
      }

      setCurrentUser(user);
      saveUserLocally(user);

      return true;
    }

    return false;
  }

  @override
  Future<void> userSignOut() async => await _repository.signOut();
}
