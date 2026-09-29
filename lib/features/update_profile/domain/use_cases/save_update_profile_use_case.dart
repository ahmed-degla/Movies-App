import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/update_profile/domain/repo/update_profile_repository.dart';

@injectable
class SaveUpdateProfileUseCase {
  const SaveUpdateProfileUseCase(this._repository);

  final UpdateProfileRepository _repository;

  FutureApiResult<bool> call({
    required String name,
    required String phone,
    required String avatar,
  }) => _repository.updateProfile(name: name, phone: phone, avatar: avatar);
}
