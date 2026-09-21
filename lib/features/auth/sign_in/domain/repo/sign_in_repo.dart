import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/network/api_result.dart';

abstract interface class SignInRepo {
  FutureApiResult<UserCredential> signInWithEmail({
    required String email,
    required String password,
  });

  FutureApiResult<UserCredential?> signInWithGoogle();
}
