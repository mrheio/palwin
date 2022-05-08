import 'package:firebase_auth/firebase_auth.dart' as FB;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noctur/user/user.dart';
import 'package:noctur/user/user_repository.dart';

class GoogleAuthService {
  final FB.FirebaseAuth _auth;
  final UserRepository _userRepository;
  final GoogleSignIn _googleSignIn;

  GoogleAuthService(this._auth, this._userRepository)
      : _googleSignIn = GoogleSignIn();

  Future<void> logInWithGoogle() async {
    await _googleSignIn.signOut();
    final googleSignInAccount = await _googleSignIn.signIn();
    if (googleSignInAccount != null) {
      final googleSignInAuthentication =
          await googleSignInAccount.authentication;
      final credential = FB.GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken);
      final userCredential = await _auth.signInWithCredential(credential);
      final user = await _userRepository.getById(userCredential.user!.uid);
      if (user == null) {
        final _user = User(
            id: userCredential.user!.uid,
            email: userCredential.user!.email!,
            username: '');
        await _userRepository.add(_user);
      }
    }
  }
}
