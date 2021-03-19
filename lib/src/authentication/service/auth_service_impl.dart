import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../model/local_user.dart';
import 'auth_service.dart';
import 'repository_service.dart';

class AuthServiceImpl implements AuthService {
  final _repository = getIt<RepositoryService>();
  final _currentUser = BehaviorSubject<LocalUser>();

  void setCurrentUser(LocalUser user) => _currentUser.sink.add(user);

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
  }

  Future<bool> userSignIn() async {
    var userCredential;
    var firebaseUser;
    var googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      var googleAuth =
          await googleUser.authentication.catchError((error) => null);

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      userCredential = await _repository.signInWithCredential(credential);
      firebaseUser = userCredential.user;
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
