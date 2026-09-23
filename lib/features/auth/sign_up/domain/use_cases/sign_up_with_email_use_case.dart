import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/sign_up/domain/repo/sign_up_repo.dart';

@singleton
class SignUpWithEmailUseCase {
  SignUpWithEmailUseCase(this._signUpRepo);

  final SignUpRepo _signUpRepo;

  FutureApiResult<UserCredential> call({
    required String email,
    required String password,
    required String name,
    String? phone,
    String? avatar,
  }) =>
      _signUpRepo.signUpWithEmail(
        email: email,
        password: password,
        name: name,
        phone: phone,
        avatar: avatar,
      );
}
