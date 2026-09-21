part of 'forgot_password_cubit.dart';

sealed class ForgotPasswordStates {
  const ForgotPasswordStates();
}

class ForgotPasswordInit extends ForgotPasswordStates {
  const ForgotPasswordInit();
}

class ForgotPasswordLoading extends ForgotPasswordStates {
  const ForgotPasswordLoading();
}

class ForgotPasswordSuccess extends ForgotPasswordStates {
  const ForgotPasswordSuccess();
}

class ForgotPasswordError extends ForgotPasswordStates {
  const ForgotPasswordError({required this.message});

  final String message;
}
