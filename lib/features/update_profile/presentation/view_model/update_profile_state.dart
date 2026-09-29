import 'package:movies/features/update_profile/domain/entity/update_profile_entity.dart';

enum UpdateProfileAction {
  none,
  profileLoaded,
  profileUpdated,
  passwordResetSent,
  accountDeleted,
  failed,
}

class UpdateProfileState {
  const UpdateProfileState({
    this.isLoadingProfile = false,
    this.isSaving = false,
    this.isSendingPasswordReset = false,
    this.isDeleting = false,
    this.selectedAvatar,
    this.profile,
    this.action = UpdateProfileAction.none,
    this.errorMessage,
  });

  final bool isLoadingProfile;
  final bool isSaving;
  final bool isSendingPasswordReset;
  final bool isDeleting;
  final String? selectedAvatar;
  final UpdateProfileEntity? profile;
  final UpdateProfileAction action;
  final String? errorMessage;

  bool get isBusy =>
      isLoadingProfile || isSaving || isSendingPasswordReset || isDeleting;

  UpdateProfileState copyWith({
    bool? isLoadingProfile,
    bool? isSaving,
    bool? isSendingPasswordReset,
    bool? isDeleting,
    String? selectedAvatar,
    UpdateProfileEntity? profile,
    UpdateProfileAction? action,
    String? errorMessage,
    bool clearErrorMessage = false,
  }) => UpdateProfileState(
    isLoadingProfile: isLoadingProfile ?? this.isLoadingProfile,
    isSaving: isSaving ?? this.isSaving,
    isSendingPasswordReset:
        isSendingPasswordReset ?? this.isSendingPasswordReset,
    isDeleting: isDeleting ?? this.isDeleting,
    selectedAvatar: selectedAvatar ?? this.selectedAvatar,
    profile: profile ?? this.profile,
    action: action ?? this.action,
    errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
  );
}
