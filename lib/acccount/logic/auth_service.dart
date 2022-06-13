import 'package:firebase_auth/firebase_auth.dart';
import 'package:noctur/common/database/base_repository.dart';
import 'package:noctur/common/exceptions/auth_exception.dart';
import 'package:noctur/user/logic/logic.dart';
import 'package:optional/optional.dart';
import 'package:rxdart/rxdart.dart';

class AuthService {
  final FirebaseAuth _auth;
  final BaseRepository<ComplexUser> _usersRepository;

  const AuthService(this._auth, this._usersRepository);

  Future<Optional<ComplexUser>> getUser() async {
    final fbUser = _auth.currentUser;
    if (fbUser != null) {
      return _usersRepository.getById(fbUser.uid);
    }
    return const Optional.empty();
  }

  Stream<Optional<ComplexUser>> getUser$() {
    return _auth.authStateChanges().switchMap((user) async* {
      if (user != null) {
        yield* _usersRepository.getById$(user.uid);
      }
      yield const Optional.empty();
    });
  }

  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (error) {
      print(error);
      throw AuthException.fromFirebase(error);
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
      final user =
          ComplexUser(id: res.user!.uid, email: email, username: username);
      await _usersRepository.add(user);
    } on FirebaseAuthException catch (error) {
      throw AuthException.fromFirebase(error);
    }
  }

  Future<void> logOut() async {
    await _auth.signOut();
  }
}
