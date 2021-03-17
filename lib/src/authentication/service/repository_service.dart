import 'package:firebase_auth/firebase_auth.dart';

import '../resource/auth_provider.dart';

class RepositoryService {
  final _fireAuthProvider = FireAuthProvider();

  Future<FirebaseUser> signInWithCredential(AuthCredential credential) =>
      _fireAuthProvider.signInWithCredential(credential);

  Future<void> signOut() => _fireAuthProvider.signOut();
}
