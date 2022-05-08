import 'package:firebase_auth/firebase_auth.dart';
import 'package:noctur/common/errors/err.dart';
import 'package:noctur/common/errors/invalid_data_format.dart';
import 'package:noctur/common/errors/other_error.dart';
import 'package:noctur/common/errors/resource_already_exists.dart';
import 'package:noctur/common/errors/resource_not_found.dart';

class AuthError extends Err {
  const AuthError(
      {required String name, required String message, required int statusCode})
      : super(name: name, message: message, statusCode: statusCode);

  static firebaseConvert(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        throw const InvalidEmailFormat();
      case 'user-not-found':
        throw const UserNotFound();
      case 'wrong-password':
        throw const UserNotFound();
      case 'weak-password':
        throw const WeakPassword();
      case 'email-already-in-use':
        throw const UserAlreadyExists();
      case 'too-many-requests':
        throw const TooManyRequests();
      default:
        throw error;
    }
  }
}
