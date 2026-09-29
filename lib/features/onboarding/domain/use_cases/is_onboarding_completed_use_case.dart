import 'package:injectable/injectable.dart';
import 'package:movies/features/onboarding/domain/repository/onboarding_repository.dart';

@Injectable()
class IsOnboardingCompletedUseCase {
  const IsOnboardingCompletedUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<bool> call() => _repository.isOnboardingCompleted();
}
