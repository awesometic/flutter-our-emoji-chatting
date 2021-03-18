import 'package:firebase_auth/firebase_auth.dart';

import '../model/local_user.dart';
import '../resource/fireauth_provider.dart';
import '../resource/firestore_provider.dart';
import 'repository_service.dart';

class RepositoryServiceImpl implements RepositoryService {
  final _fireAuthProvider = FireAuthProvider();
  final _fireStoreProvider = FireStoreProvider();

  Future<UserCredential> signInWithCredential(AuthCredential credential) =>
      _fireAuthProvider.signInWithCredential(credential);

  Future<void> signOut() => _fireAuthProvider.signOut();

  Future<void> registerUser(LocalUser user) =>
      _fireStoreProvider.registerUser(user);

  Future<LocalUser> getUser(String userId) {
    return _fireStoreProvider.getUser(userId);
  }

  Future<LocalUser> updateUser(LocalUser user) {
    return _fireStoreProvider.updateUser(user);
  }
}
