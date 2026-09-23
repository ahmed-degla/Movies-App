import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/internet_checker/internet_checker.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/sign_up/data/datasource/sign_up_datasource.dart';
import 'package:movies/features/auth/sign_up/domain/repo/sign_up_repo.dart';

@Injectable(as: SignUpRepo)
class SignUpRepoImpl implements SignUpRepo {
  SignUpRepoImpl(this._signUpDataSource);

  final SignUpDataSource _signUpDataSource;

  @override
  FutureApiResult<UserCredential> signUpWithEmail({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? avatar,
  }) async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }
    return _signUpDataSource.signUpWithEmail(
      email: email,
      password: password,
      name: name,
      phone: phone,
      avatar: avatar,
    );
  }
}
