import 'package:flutter_test/flutter_test.dart';
import 'package:movies/features/splash/presentation/view_model/splash_cubit.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('routes authenticated users home', () async {
    final cubit = SplashCubit(
      isAuthenticated: () => true,
      isOnboardingCompleted: () async => false,
      splashDuration: Duration.zero,
    );

    await cubit.start();

    expect(cubit.state.destination, SplashDestination.home);
    await cubit.close();
  });

  test('routes first-time users to onboarding', () async {
    final cubit = SplashCubit(
      isAuthenticated: () => false,
      isOnboardingCompleted: () async => false,
      splashDuration: Duration.zero,
    );

    await cubit.start();

    expect(cubit.state.destination, SplashDestination.onboarding);
    await cubit.close();
  });

  test('routes users who completed onboarding to sign in', () async {
    final cubit = SplashCubit(
      isAuthenticated: () => false,
      isOnboardingCompleted: () async => true,
      splashDuration: Duration.zero,
    );

    await cubit.start();

    expect(cubit.state.destination, SplashDestination.signIn);
    await cubit.close();
  });
}
