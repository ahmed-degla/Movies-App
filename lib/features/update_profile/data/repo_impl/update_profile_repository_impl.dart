import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/update_profile/data/datasource/update_profile_data_source.dart';
import 'package:movies/features/update_profile/domain/entity/update_profile_entity.dart';
import 'package:movies/features/update_profile/domain/repo/update_profile_repository.dart';

@Injectable(as: UpdateProfileRepository)
class UpdateProfileRepositoryImpl implements UpdateProfileRepository {
  const UpdateProfileRepositoryImpl(this._dataSource);

  final UpdateProfileDataSource _dataSource;

  @override
  FutureApiResult<UpdateProfileEntity> getProfile() async {
    try {
      final model = await _dataSource.getProfile();
      return ApiSuccess(data: model.toEntity());
    } on FirebaseAuthException catch (error) {
      return ApiError(message: 'firebase_auth:${error.code}');
    } on Object catch (error) {
      return ApiError(message: error.toString());
    }
  }

  @override
  FutureApiResult<bool> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) => _run(
    () => _dataSource.updateProfile(name: name, phone: phone, avatar: avatar),
  );

  @override
  FutureApiResult<bool> sendPasswordResetEmail() =>
      _run(_dataSource.sendPasswordResetEmail);

  @override
  FutureApiResult<bool> deleteAccount({String? password}) =>
      _run(() => _dataSource.deleteAccount(password: password));

  FutureApiResult<bool> _run(Future<void> Function() operation) async {
    try {
      await operation();
      return const ApiSuccess(data: true);
    } on FirebaseAuthException catch (error) {
      return ApiError(message: 'firebase_auth:${error.code}');
    } on Object catch (error) {
      return ApiError(message: error.toString());
    }
  }
}
