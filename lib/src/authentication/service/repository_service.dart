import 'package:firebase_auth/firebase_auth.dart';

import '../model/local_user.dart';

abstract class RepositoryService {
  Future<UserCredential> signInWithCredential(AuthCredential credential);

  Future<void> signOut();

  Future<void> registerUser(LocalUser user);

  Future<LocalUser> getUser(String userId);

  Future<LocalUser> updateUser(LocalUser user);
}
