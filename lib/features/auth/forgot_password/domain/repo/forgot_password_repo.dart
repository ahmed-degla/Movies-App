import 'package:movies/core/network/api_result.dart';

abstract interface class ForgotPasswordRepo {
  FutureApiResult<void> sendPasswordResetEmail({
    required String email,
  });
}
