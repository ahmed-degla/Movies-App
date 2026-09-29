import 'package:injectable/injectable.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/features/update_profile/data/datasource/update_profile_data_source.dart';
import 'package:movies/features/update_profile/data/model/update_profile_model.dart';

@Injectable(as: UpdateProfileDataSource)
class UpdateProfileDataSourceImpl implements UpdateProfileDataSource {
  UpdateProfileDataSourceImpl(this._authService);

  final FirebaseAuthService _authService;

  @override
  Future<UpdateProfileModel> getProfile() async {
    final authUser = _authService.currentUser;
    if (authUser == null) {
      throw StateError('A signed-in user is required.');
    }

    final storedProfile = await _authService.getCurrentUserData();
    return UpdateProfileModel.fromSources(
      storedProfile: storedProfile,
      authUser: authUser,
    );
  }

  @override
  Future<void> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) => _authService.updateProfile(name: name, phone: phone, avatar: avatar);

  @override
  Future<void> sendPasswordResetEmail() async {
    final email = _authService.currentUser?.email;
    if (email == null || email.isEmpty) {
      throw StateError('The signed-in account has no email address.');
    }

    await _authService.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> deleteAccount({String? password}) async {
    await _authService.reauthenticateCurrentUser(password: password);
    await _authService.deleteAccount();
  }
}
