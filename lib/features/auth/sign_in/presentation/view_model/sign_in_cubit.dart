import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/auth/sign_in/domain/use_cases/sign_in_with_email_use_case.dart';
import 'package:movies/features/auth/sign_in/domain/use_cases/sign_in_with_google_use_case.dart';

part 'sign_in_states.dart';

@Injectable()
class SignInCubit extends Cubit<SignInStates> {
  SignInCubit(this._signInWithEmailUseCase, this._signInWithGoogleUseCase)
    : super(const SignInInit());

  final SignInWithEmailUseCase _signInWithEmailUseCase;
  final SignInWithGoogleUseCase _signInWithGoogleUseCase;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isEnglish = true;

  static SignInCubit of(BuildContext context) =>
      BlocProvider.of<SignInCubit>(context);

  bool get isStateLoading => state is SignInLoading;

  void toggleLanguage(bool value) {
    isEnglish = value;
    emit(state);
  }

  Future<void> signInWithEmail({
    required String email,
    required String password,
  }) async {
    _emit(const SignInLoading());
    if (!formKey.currentState!.validate()) return;

    final result = await _signInWithEmailUseCase.call(
      email: email,
      password: password,
    );

    switch (result) {
      case ApiSuccess():
        _emit(const SignInSuccess());
      case ApiError(:final message):
        _emit(SignInError(message: message));
    }
  }

  Future<void> signInWithGoogle() async {
    _emit(const SignInLoading());

    final result = await _signInWithGoogleUseCase.call();

    switch (result) {
      case ApiSuccess(:final data):
        if (data != null) {
          _emit(const SignInSuccess());
        } else {
          // User cancelled sign-in
          _emit(const SignInInit());
        }
      case ApiError(:final message):
        _emit(SignInError(message: message));
    }
  }

  void _emit(SignInStates state) {
    if (!isClosed) {
      emit(state);
    }
  }

  @override
  Future<void> close() {
    emailController.dispose();
    passwordController.dispose();
    return super.close();
  }
}
