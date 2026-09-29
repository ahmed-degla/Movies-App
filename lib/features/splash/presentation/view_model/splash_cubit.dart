import 'package:flutter_bloc/flutter_bloc.dart';

enum SplashDestination { home, onboarding, signIn }

class SplashState {
  const SplashState({this.destination, this.hasError = false});

  final SplashDestination? destination;
  final bool hasError;
}

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({
    required this._isAuthenticated,
    required this._isOnboardingCompleted,
    this.splashDuration = const Duration(seconds: 3),
  }) : super(const SplashState());

  final bool Function() _isAuthenticated;
  final Future<bool> Function() _isOnboardingCompleted;
  final Duration splashDuration;

  Future<void> start() async {
    await Future<void>.delayed(splashDuration);
    await resolveDestination();
  }

  Future<void> retry() => resolveDestination();

  Future<void> resolveDestination() async {
    try {
      final destination = _isAuthenticated()
          ? SplashDestination.home
          : await _isOnboardingCompleted()
          ? SplashDestination.signIn
          : SplashDestination.onboarding;

      if (!isClosed) {
        emit(SplashState(destination: destination));
      }
    } on Object catch (error, stackTrace) {
      addError(error, stackTrace);
      if (!isClosed) {
        emit(const SplashState(hasError: true));
      }
    }
  }
}
