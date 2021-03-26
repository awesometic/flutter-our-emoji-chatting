import 'package:our_emoji_chatting/src/authentication/constant/auth_type.dart';

import '../model/local_user.dart';

abstract class AuthService {
  void setCurrentUser(LocalUser user);

  LocalUser getCurrentUser();

  Future<bool> isUserSignedIn();

  Future<LocalUser> getCurrentLocalUser();

  void saveUserLocally(LocalUser user);

  Future<bool> userSignIn(AuthType type);
}
