import 'package:firebase_auth/firebase_auth.dart';

import '../utils/status_codes.dart';
import 'custom_exception.dart';

class AuthException extends CustomException {
  const AuthException({
    required String name,
    required String message,
    required int statusCode,
  }) : super(name: name, message: message, statusCode: statusCode);

  factory AuthException._invalidEmail() {
    return const AuthException(
        name: 'invalid-email-format',
        message: 'Email invalid',
        statusCode: StatusCode.unprocessable);
  }

  factory AuthException._userNotFound() {
    return const AuthException(
      name: 'user-not-found',
      message: 'Nu exista user cu aceste date',
      statusCode: StatusCode.notFound,
    );
  }

  factory AuthException._weakPassword() {
    return const AuthException(
      name: 'weak-password',
      message: 'Parola prea slaba',
      statusCode: StatusCode.unprocessable,
    );
  }

  factory AuthException._userAlreadyExists() {
    return const AuthException(
      name: 'user-already-exists',
      message: 'Un user cu aceste date exista deja',
      statusCode: StatusCode.conflict,
    );
  }

  factory AuthException._tooManyRequests() {
    return const AuthException(
      name: 'too-many-requests',
      message: 'Ai incercat de prea multe ori. Incearca mai tarziu.',
      statusCode: StatusCode.badRequest,
    );
  }

  factory AuthException._networkRequestFailed() {
    return const AuthException(
      name: 'network-request-failed',
      message: 'A aparut o problema la conexiune.',
      statusCode: StatusCode.internal,
    );
  }

  factory AuthException.fromFirebase(FirebaseAuthException error) {
    switch (error.code) {
      case 'invalid-email':
        return AuthException._invalidEmail();
      case 'user-not-found':
        return AuthException._userNotFound();
      case 'wrong-password':
        return AuthException._userNotFound();
      case 'weak-password':
        return AuthException._weakPassword();
      case 'email-already-in-use':
        return AuthException._userAlreadyExists();
      case 'too-many-requests':
        return AuthException._tooManyRequests();
      case 'network-request-failed':
        return AuthException._networkRequestFailed();
      default:
        throw error;
    }
  }
}
