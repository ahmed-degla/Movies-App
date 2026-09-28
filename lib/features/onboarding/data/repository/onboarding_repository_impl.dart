import 'package:injectable/injectable.dart';
import 'package:movies/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  @override
  Future<void> markOnboardingCompleted() async {
    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setBool('onboarding_completed', true);

    if (!saved) {
      throw StateError('Failed to save onboarding completion.');
    }
  }
}
