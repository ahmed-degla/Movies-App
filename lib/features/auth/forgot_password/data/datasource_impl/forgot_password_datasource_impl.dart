import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/forgot_password/data/datasource/forgot_password_datasource.dart';

@Injectable(as: ForgotPasswordDataSource)
class ForgotPasswordDataSourceImpl implements ForgotPasswordDataSource {
  @override
  FutureApiResult<void> sendPasswordResetEmail({required String email}) async {
    try {
      await getIt.get<FirebaseAuthService>().sendPasswordResetEmail(
        email: email,
      );
      return const ApiSuccess(data: null);
    } on FirebaseAuthException catch (e) {
      return ApiError(message: 'firebase_auth:${e.code}');
    } on Object catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
