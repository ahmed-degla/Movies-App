import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/sign_up/data/datasource/sign_up_datasource.dart';

@Injectable(as: SignUpDataSource)
class SignUpDataSourceImpl implements SignUpDataSource {
  @override
  FutureApiResult<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? avatar,
  }) async {
    try {
      final credential = await getIt.get<FirebaseAuthService>().signUpWithEmail(
        email: email,
        password: password,
        name: name,
        phone: phone,
        avatar: avatar,
      );
      return ApiSuccess(data: credential);
    } on FirebaseAuthException catch (e) {
      return ApiError(message: e.message ?? 'Registration failed');
    } on Object catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
