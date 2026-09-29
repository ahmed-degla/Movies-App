import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/enum/profile_avatar.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/update_profile/domain/entity/update_profile_entity.dart';
import 'package:movies/features/update_profile/domain/use_cases/delete_profile_account_use_case.dart';
import 'package:movies/features/update_profile/domain/use_cases/get_update_profile_use_case.dart';
import 'package:movies/features/update_profile/domain/use_cases/save_update_profile_use_case.dart';
import 'package:movies/features/update_profile/domain/use_cases/send_profile_password_reset_use_case.dart';
import 'package:movies/features/update_profile/presentation/view_model/update_profile_state.dart';

@injectable
class UpdateProfileCubit extends Cubit<UpdateProfileState> {
  UpdateProfileCubit(
    this._getUpdateProfile,
    this._saveUpdateProfile,
    this._sendPasswordReset,
    this._deleteProfileAccount,
  ) : super(const UpdateProfileState());

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  final GetUpdateProfileUseCase _getUpdateProfile;
  final SaveUpdateProfileUseCase _saveUpdateProfile;
  final SendProfilePasswordResetUseCase _sendPasswordReset;
  final DeleteProfileAccountUseCase _deleteProfileAccount;

  Future<void> loadProfile() async {
    if (state.isBusy) return;
    emit(
      state.copyWith(
        isLoadingProfile: true,
        action: UpdateProfileAction.none,
        clearErrorMessage: true,
      ),
    );

    final result = await _getUpdateProfile();
    if (isClosed) return;
    switch (result) {
      case ApiSuccess<UpdateProfileEntity>(:final data):
        final selectedAvatar = data.avatar == null
            ? null
            : Avatar.resolveKnownImagePath(data.avatar!);
        nameController.text = data.name;
        phoneController.text = data.phone;
        emit(
          state.copyWith(
            isLoadingProfile: false,
            profile: data,
            selectedAvatar: selectedAvatar,
            action: UpdateProfileAction.profileLoaded,
          ),
        );
      case ApiError<UpdateProfileEntity>(:final message):
        _emitFailure(message, isLoadingProfile: false);
    }
  }

  Future<void> saveProfile() async {
    if (state.isBusy) return;
    if (formKey.currentState?.validate() == false) return;
    emit(
      state.copyWith(
        isSaving: true,
        action: UpdateProfileAction.none,
        clearErrorMessage: true,
      ),
    );

    final result = await _saveUpdateProfile(
      name: nameController.text.trim(),
      phone: phoneController.text.trim(),
      avatar: state.selectedAvatar ?? Avatar.profileImage1.avatar.path,
    );
    if (isClosed) return;
    switch (result) {
      case ApiSuccess<bool>():
        emit(
          state.copyWith(
            isSaving: false,
            action: UpdateProfileAction.profileUpdated,
          ),
        );
      case ApiError<bool>(:final message):
        _emitFailure(message, isSaving: false);
    }
  }

  void selectAvatar(String avatar) {
    if (state.isBusy || Avatar.resolveKnownImagePath(avatar) == null) return;
    emit(
      state.copyWith(
        selectedAvatar: avatar,
        action: UpdateProfileAction.none,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> sendPasswordResetEmail() async {
    if (state.isBusy) return;
    emit(
      state.copyWith(
        isSendingPasswordReset: true,
        action: UpdateProfileAction.none,
        clearErrorMessage: true,
      ),
    );

    final result = await _sendPasswordReset();
    if (isClosed) return;
    switch (result) {
      case ApiSuccess<bool>():
        emit(
          state.copyWith(
            isSendingPasswordReset: false,
            action: UpdateProfileAction.passwordResetSent,
          ),
        );
      case ApiError<bool>(:final message):
        _emitFailure(message, isSendingPasswordReset: false);
    }
  }

  Future<void> deleteAccount({String? password}) async {
    if (state.isBusy) return;
    emit(
      state.copyWith(
        isDeleting: true,
        action: UpdateProfileAction.none,
        clearErrorMessage: true,
      ),
    );

    final result = await _deleteProfileAccount(password: password);
    if (isClosed) return;
    switch (result) {
      case ApiSuccess<bool>():
        emit(
          state.copyWith(
            isDeleting: false,
            action: UpdateProfileAction.accountDeleted,
          ),
        );
      case ApiError<bool>(:final message):
        _emitFailure(message, isDeleting: false);
    }
  }

  void _emitFailure(
    String message, {
    bool? isLoadingProfile,
    bool? isSaving,
    bool? isSendingPasswordReset,
    bool? isDeleting,
  }) {
    emit(
      state.copyWith(
        isLoadingProfile: isLoadingProfile,
        isSaving: isSaving,
        isSendingPasswordReset: isSendingPasswordReset,
        isDeleting: isDeleting,
        action: UpdateProfileAction.failed,
        errorMessage: message,
      ),
    );
  }

  @override
  Future<void> close() {
    nameController.dispose();
    phoneController.dispose();
    return super.close();
  }
}
