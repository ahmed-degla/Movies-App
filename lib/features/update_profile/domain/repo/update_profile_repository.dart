import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/update_profile/domain/entity/update_profile_entity.dart';

abstract interface class UpdateProfileRepository {
  FutureApiResult<UpdateProfileEntity> getProfile();

  FutureApiResult<bool> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  });

  FutureApiResult<bool> sendPasswordResetEmail();

  FutureApiResult<bool> deleteAccount({String? password});
}
