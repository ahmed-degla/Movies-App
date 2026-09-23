import 'package:injectable/injectable.dart';
import 'package:movies/core/internet_checker/internet_checker.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/forgot_password/data/datasource/forgot_password_datasource.dart';
import 'package:movies/features/auth/forgot_password/domain/repo/forgot_password_repo.dart';

@Injectable(as: ForgotPasswordRepo)
class ForgotPasswordRepoImpl implements ForgotPasswordRepo {
  ForgotPasswordRepoImpl(this._forgotPasswordDataSource);

  final ForgotPasswordDataSource _forgotPasswordDataSource;

  @override
  FutureApiResult<void> sendPasswordResetEmail({
    required String email,
  }) async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }
    return _forgotPasswordDataSource.sendPasswordResetEmail(email: email);
  }
}
