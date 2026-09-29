import 'package:injectable/injectable.dart';
import 'package:movies/features/onboarding/domain/repository/onboarding_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  static const _completionKey = 'onboarding_completed';

  @override
  Future<bool> isOnboardingCompleted() async {
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_completionKey) ?? false;
  }

  @override
  Future<void> markOnboardingCompleted() async {
    final preferences = await SharedPreferences.getInstance();
    final saved = await preferences.setBool(_completionKey, true);

    if (!saved) {
      throw StateError('Failed to save onboarding completion.');
    }
  }
}
