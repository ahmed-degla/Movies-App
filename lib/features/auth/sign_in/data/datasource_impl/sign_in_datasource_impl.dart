import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/sign_in/data/datasource/sign_in_datasource.dart';

@Injectable(as: SignInDataSource)
class SignInDataSourceImpl implements SignInDataSource {
  @override
  FutureApiResult<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await getIt.get<FirebaseAuthService>().signInWithEmail(
        email: email,
        password: password,
      );
      return ApiSuccess(data: credential);
    } on FirebaseAuthException catch (e) {
      return ApiError(message: e.message ?? 'Authentication failed');
    } on Object catch (e) {
      return ApiError(message: e.toString());
    }
  }

  @override
  FutureApiResult<UserCredential?> signInWithGoogle() async {
    try {
      final credential = await getIt.get<FirebaseAuthService>().signInWithGoogle();
      return ApiSuccess(data: credential);
    } on FirebaseAuthException catch (e) {
      return ApiError(message: e.message ?? 'Google Sign-In failed');
    } on Object catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
