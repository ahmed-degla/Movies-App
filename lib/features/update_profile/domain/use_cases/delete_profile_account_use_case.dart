import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/update_profile/domain/repo/update_profile_repository.dart';

@injectable
class DeleteProfileAccountUseCase {
  const DeleteProfileAccountUseCase(this._repository);

  final UpdateProfileRepository _repository;

  FutureApiResult<bool> call({String? password}) =>
      _repository.deleteAccount(password: password);
}
