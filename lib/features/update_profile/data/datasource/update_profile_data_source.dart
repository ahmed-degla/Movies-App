import 'package:movies/features/update_profile/data/model/update_profile_model.dart';

abstract interface class UpdateProfileDataSource {
  Future<UpdateProfileModel> getProfile();

  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  });

  Future<void> sendPasswordResetEmail();

  Future<void> deleteAccount({String? password});
}
