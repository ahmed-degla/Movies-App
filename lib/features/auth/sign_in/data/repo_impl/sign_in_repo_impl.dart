import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/internet_checker/internet_checker.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/sign_in/data/datasource/sign_in_datasource.dart';
import 'package:movies/features/auth/sign_in/domain/repo/sign_in_repo.dart';

@Injectable(as: SignInRepo)
class SignInRepoImpl implements SignInRepo {
  SignInRepoImpl(this._signInDataSource);

  final SignInDataSource _signInDataSource;

  @override
  FutureApiResult<UserCredential> signInWithEmail({
    required String email,
    required String password,
  }) async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }
    return _signInDataSource.signInWithEmail(
      email: email,
      password: password,
    );
  }

  @override
  FutureApiResult<UserCredential?> signInWithGoogle() async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }
    return _signInDataSource.signInWithGoogle();
  }
}
