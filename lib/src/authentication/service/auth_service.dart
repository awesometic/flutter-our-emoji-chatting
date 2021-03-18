import '../model/local_user.dart';

abstract class AuthService {
  void setCurrentUser(LocalUser user);

  void saveUserLocally(LocalUser user);

  Future<bool> userSignIn();
}
