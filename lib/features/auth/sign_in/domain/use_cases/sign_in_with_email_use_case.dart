import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/sign_in/domain/repo/sign_in_repo.dart';

@singleton
class SignInWithEmailUseCase {
  SignInWithEmailUseCase(this._signInRepo);

  final SignInRepo _signInRepo;

  FutureApiResult<UserCredential> call({
    required String email,
    required String password,
  }) =>
      _signInRepo.signInWithEmail(
        email: email,
        password: password,
      );
}
