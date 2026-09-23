import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/network/api_result.dart';

abstract interface class SignUpRepo {
  FutureApiResult<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? avatar,
  });
}
