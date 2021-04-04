import 'dart:convert';
import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth_oauth/firebase_auth_oauth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:crypto/crypto.dart';

import '../../../main.dart';
import '../constant/auth_type.dart';
import '../model/local_user.dart';
import 'auth_service.dart';
import 'repository_service.dart';

class AuthServiceImpl implements AuthService {
  final _repository = getIt<RepositoryService>();
  final _currentUser = BehaviorSubject<LocalUser>();

  void setCurrentUser(LocalUser user) => _currentUser.sink.add(user);

  LocalUser getCurrentUser() {
    return _currentUser.value;
  }

  Future<bool> isUserSignedIn() async {
    return GoogleSignIn().isSignedIn();
  }

  Future<LocalUser> getCurrentLocalUser() async {
    var prefs = await SharedPreferences.getInstance();
    LocalUser user;
    var id = prefs.getString('id');
    var name = prefs.getString('name');
    var avatar = prefs.getString('avatar');
    var aboutMe = prefs.getString('aboutMe');
    var oppositeUserId = prefs.getString('oppositeUserId');
    if (id != null) {
      user = LocalUser(
          id: id,
          name: name,
          avatar: avatar,
          aboutMe: aboutMe,
          oppositeUserId: [oppositeUserId]);
    }
    return user;
  }

  void saveUserLocally(LocalUser user) async {
    final _prefs = await SharedPreferences.getInstance();

    _prefs.setString('id', user.id);

    if (user.name != null) {
      _prefs.setString('name', user.name);
    }

    if (user.avatar != null) {
      _prefs.setString('avatar', user.avatar);
    }

    if (user.aboutMe != null) {
      _prefs.setString('aboutMe', user.aboutMe);
    }

    if (user.oppositeUserId != null) {
      _prefs.setStringList('oppositeUserId', user.oppositeUserId);
    }
  }

  Future<bool> userSignIn(AuthType type) async {
    var userCredential;
    var firebaseUser;

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
        final charset =
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
}
