import 'package:flutter_test/flutter_test.dart';
import 'package:movies/core/enum/profile_avatar.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/update_profile/domain/entity/update_profile_entity.dart';
import 'package:movies/features/update_profile/domain/repo/update_profile_repository.dart';
import 'package:movies/features/update_profile/domain/use_cases/delete_profile_account_use_case.dart';
import 'package:movies/features/update_profile/domain/use_cases/get_update_profile_use_case.dart';
import 'package:movies/features/update_profile/domain/use_cases/save_update_profile_use_case.dart';
import 'package:movies/features/update_profile/domain/use_cases/send_profile_password_reset_use_case.dart';
import 'package:movies/features/update_profile/presentation/view_model/update_profile_cubit.dart';
import 'package:movies/features/update_profile/presentation/view_model/update_profile_state.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _FakeUpdateProfileRepository repository;
  late UpdateProfileCubit cubit;

  setUp(() {
    repository = _FakeUpdateProfileRepository();
    cubit = UpdateProfileCubit(
      GetUpdateProfileUseCase(repository),
      SaveUpdateProfileUseCase(repository),
      SendProfilePasswordResetUseCase(repository),
      DeleteProfileAccountUseCase(repository),
    );
  });

  tearDown(() async {
    await cubit.close();
  });

  test(
    'loads profile and completes profile actions through use cases',
    () async {
      await cubit.loadProfile();
      expect(cubit.state.action, UpdateProfileAction.profileLoaded);
      expect(cubit.state.profile?.name, 'Test User');

      cubit.nameController.text = 'Updated User';
      cubit.phoneController.text = '+12345678901';
      cubit.selectAvatar(Avatar.profileImage2.avatar.path);
      expect(cubit.state.selectedAvatar, Avatar.profileImage2.avatar.path);
      await cubit.saveProfile();
      expect(cubit.state.action, UpdateProfileAction.profileUpdated);

      await cubit.sendPasswordResetEmail();
      expect(cubit.state.action, UpdateProfileAction.passwordResetSent);

      await cubit.deleteAccount(password: 'password');
      expect(cubit.state.action, UpdateProfileAction.accountDeleted);
      expect(repository.deletedWithPassword, 'password');
    },
  );
}

class _FakeUpdateProfileRepository implements UpdateProfileRepository {
  String? deletedWithPassword;

  @override
  FutureApiResult<UpdateProfileEntity> getProfile() async => const ApiSuccess(
    data: UpdateProfileEntity(
      name: 'Test User',
      phone: '+12345678901',
      avatar: 'avatar.png',
      requiresPassword: true,
    ),
  );

  @override
  FutureApiResult<bool> updateProfile({
    required String name,
    required String phone,
    required String avatar,
  }) async => const ApiSuccess(data: true);

  @override
  FutureApiResult<bool> sendPasswordResetEmail() async =>
      const ApiSuccess(data: true);

  @override
  FutureApiResult<bool> deleteAccount({String? password}) async {
    deletedWithPassword = password;
    return const ApiSuccess(data: true);
  }
}
