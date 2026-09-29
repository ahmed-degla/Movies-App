import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/update_profile/domain/entity/update_profile_entity.dart';
import 'package:movies/features/update_profile/domain/repo/update_profile_repository.dart';

@injectable
class GetUpdateProfileUseCase {
  const GetUpdateProfileUseCase(this._repository);

  final UpdateProfileRepository _repository;

  FutureApiResult<UpdateProfileEntity> call() => _repository.getProfile();
}
