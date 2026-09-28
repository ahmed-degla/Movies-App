import 'package:injectable/injectable.dart';

import 'package:movies/features/onboarding/domain/repository/onboarding_repository.dart';

@Injectable()
class MarkOnboardingCompletedUseCase {
  const MarkOnboardingCompletedUseCase(this._repository);

  final OnboardingRepository _repository;

  Future<void> call() => _repository.markOnboardingCompleted();
}
