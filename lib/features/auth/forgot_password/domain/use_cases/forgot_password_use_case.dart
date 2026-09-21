import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/forgot_password/domain/repo/forgot_password_repo.dart';

@singleton
class ForgotPasswordUseCase {
  ForgotPasswordUseCase(this._forgotPasswordRepo);

  final ForgotPasswordRepo _forgotPasswordRepo;

  FutureApiResult<void> call({required String email}) =>
      _forgotPasswordRepo.sendPasswordResetEmail(email: email);
}
