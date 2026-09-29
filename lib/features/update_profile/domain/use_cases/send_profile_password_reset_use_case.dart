import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/update_profile/domain/repo/update_profile_repository.dart';

@injectable
class SendProfilePasswordResetUseCase {
  const SendProfilePasswordResetUseCase(this._repository);

  final UpdateProfileRepository _repository;

  FutureApiResult<bool> call() => _repository.sendPasswordResetEmail();
}
