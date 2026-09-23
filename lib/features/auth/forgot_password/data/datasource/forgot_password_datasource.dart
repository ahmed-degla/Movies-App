import 'package:movies/core/network/api_result.dart';

abstract interface class ForgotPasswordDataSource {
  FutureApiResult<void> sendPasswordResetEmail({
    required String email,
  });
}
