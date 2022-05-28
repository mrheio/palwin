import 'package:firebase_auth/firebase_auth.dart' as FB;
import 'package:rxdart/rxdart.dart';

import '../common/errors/auth_error.dart';
import '../user/user.dart';
import '../user/user_repository.dart';

class AuthService {
  final FB.FirebaseAuth _auth;
  final UserRepository _userRepository;

  AuthService(this._auth, this._userRepository);

  Future<User?> getLoggedUser() async {
    final user = _auth.currentUser;
    if (user != null) {
      return _userRepository.getById(user.uid);
    }
    return null;
  }

  Stream<User?> getLoggedUser$() {
    return _auth.authStateChanges().switchMap((user) async* {
      if (user != null) {
        yield* _userRepository.getById$(user.uid);
      }
      yield null;
    });
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FB.FirebaseAuthException catch (error) {
      throw AuthError.firebaseConvert(error);
    }
  }

  Future<void> register({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final res = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      final user = User(id: res.user!.uid, email: email, username: username);
      await _userRepository.add(user);
    } on FB.FirebaseAuthException catch (error) {
      throw AuthError.firebaseConvert(error);
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
