import 'package:firebase_auth/firebase_auth.dart';

class FireAuthProvider {
  final _fireAuth = FirebaseAuth.instance;

  Future<UserCredential> signInWithCredential(AuthCredential credential) async {
    return _fireAuth.signInWithCredential(credential);
  }

  Future<void> signOut() async {
    return _fireAuth.signOut();
  }
}
