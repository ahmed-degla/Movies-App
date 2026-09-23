part of 'sign_up_cubit.dart';

sealed class SignUpStates {
  const SignUpStates();
}

class SignUpInit extends SignUpStates {
  const SignUpInit();
}

class SignUpLoading extends SignUpStates {
  const SignUpLoading();
}

class SignUpSuccess extends SignUpStates {
  const SignUpSuccess();
}

class SignUpError extends SignUpStates {
  const SignUpError({required this.message});

  final String message;
}
