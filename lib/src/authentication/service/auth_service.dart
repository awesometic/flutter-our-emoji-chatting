import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final _repository = locator<RepositoryService>();

  Future<bool> userSignIn() async {
    var firebaseUser;
    var googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      var googleAuth =
          await googleUser.authentication.catchError((error) => null);

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);

      firebaseUser = await _repository.signInWithCredential(credential);
    }
  }
}
