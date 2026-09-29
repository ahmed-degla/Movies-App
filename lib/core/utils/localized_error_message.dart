import 'package:flutter/widgets.dart';
import 'package:movies/core/utils/app_utils.dart';

String localizedErrorMessage(BuildContext context, String message) {
  switch (message) {
    case 'No internet connection':
    case 'network-request-failed':
      return tr.noInternetConnection;
    case 'Invalid response format':
      return tr.invalidResponseFormat;
    case 'Movie details not found':
      return tr.movieNotFound;
    case 'Google Sign-In did not return an ID token.':
    case 'google-sign-in-no-id-token':
      return tr.googleSignInTokenMissing;
    case 'invalid-email':
      return tr.validEmail;
    case 'email-already-in-use':
      return tr.emailAlreadyInUse;
    case 'weak-password':
      return tr.weakPassword;
    case 'too-many-requests':
      return tr.tooManyRequests;
    case 'wrong-password':
    case 'user-not-found':
    case 'invalid-credential':
      return tr.invalidCredentials;
  }

  if (message.startsWith('firebase_auth:')) {
    final code = message.substring('firebase_auth:'.length);
    final knownError = switch (code) {
      'invalid-email' => tr.validEmail,
      'email-already-in-use' => tr.emailAlreadyInUse,
      'weak-password' => tr.weakPassword,
      'too-many-requests' => tr.tooManyRequests,
      'network-request-failed' => tr.noInternetConnection,
      'wrong-password' ||
      'user-not-found' ||
      'invalid-credential' => tr.invalidCredentials,
      'google-sign-in-no-id-token' => tr.googleSignInTokenMissing,
      _ => tr.authenticationFailed,
    };
    return knownError;
  }

  return tr.requestFailed;
}
