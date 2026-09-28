part of 'sign_in_cubit.dart';

sealed class SignInStates {
  const SignInStates();
}

class SignInInit extends SignInStates {
  const SignInInit();
}

class SignInLoading extends SignInStates {
  const SignInLoading({
    required this.type,
  });

  final SignInLoadingType type;
}

enum SignInLoadingType {
  email,
  google,
}

class SignInSuccess extends SignInStates {
  const SignInSuccess();
}

class SignInError extends SignInStates {
  const SignInError({
    required this.message,
  });

  final String message;
}