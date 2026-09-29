import 'package:firebase_auth/firebase_auth.dart';
import 'package:movies/core/models/user_model.dart';
import 'package:movies/features/update_profile/domain/entity/update_profile_entity.dart';

class UpdateProfileModel {
  const UpdateProfileModel({
    required this.name,
    required this.phone,
    required this.avatar,
    required this.requiresPassword,
  });

  factory UpdateProfileModel.fromSources({
    required UserModel? storedProfile,
    required User? authUser,
  }) {
    final providerIds = authUser?.providerData
        .map((provider) => provider.providerId)
        .toSet();

    return UpdateProfileModel(
      name: storedProfile?.name.isNotEmpty == true
          ? storedProfile!.name
          : authUser?.displayName ?? '',
      phone: storedProfile?.phone?.isNotEmpty == true
          ? storedProfile!.phone!
          : authUser?.phoneNumber ?? '',
      avatar:
          storedProfile?.avatar ?? storedProfile?.image ?? authUser?.photoURL,
      requiresPassword:
          providerIds?.contains(EmailAuthProvider.PROVIDER_ID) ?? false,
    );
  }

  final String name;
  final String phone;
  final String? avatar;
  final bool requiresPassword;

  UpdateProfileEntity toEntity() => UpdateProfileEntity(
    name: name,
    phone: phone,
    avatar: avatar,
    requiresPassword: requiresPassword,
  );
}
