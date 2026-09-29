import 'package:flutter_test/flutter_test.dart';
import 'package:movies/features/onboarding/data/repository/onboarding_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late OnboardingRepositoryImpl repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    repository = OnboardingRepositoryImpl();
  });

  test('reports onboarding incomplete until completion is saved', () async {
    expect(await repository.isOnboardingCompleted(), isFalse);

    await repository.markOnboardingCompleted();

    expect(await repository.isOnboardingCompleted(), isTrue);
  });
}
