import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/enum/profile_avatar.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/update_profile/presentation/view_model/update_profile_cubit.dart';
import 'package:movies/features/update_profile/presentation/view_model/update_profile_state.dart';
import 'package:movies/features/update_profile/presentation/widgets/pick_avatar_bottom_sheet.dart';
import 'package:movies/features/update_profile/presentation/widgets/update_profile_actions.dart';
import 'package:movies/features/update_profile/presentation/widgets/update_profile_editor.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_back_button.dart';
import 'package:movies/widgets/app_bar.dart';
import 'package:movies/widgets/app_snack_bar.dart';
import 'package:movies/widgets/app_text.dart';

class UpdateProfileView extends StatelessWidget {
  const UpdateProfileView({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<UpdateProfileCubit, UpdateProfileState>(
    listener: _handleState,
    builder: (context, state) {
      final cubit = context.read<UpdateProfileCubit>();
      final isEnabled = !state.isBusy;

      return Scaffold(
        appBar: AppAppBar(
          titleWidget: AppText(
            text: tr.editProfile,
            color: appColors.primary,
            fontSize: context.sp(16),
          ),
          leading: AppBackButton(
            child: UnconstrainedBox(child: Assets.images.svg.backArrow.svg()),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: context.edgeInsets(horizontal: 16),
            child: Form(
              key: cubit.formKey,
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: UpdateProfileEditor(
                        nameController: cubit.nameController,
                        phoneController: cubit.phoneController,
                        selectedAvatar:
                            state.selectedAvatar ??
                            Avatar.profileImage1.avatar.path,
                        onPickAvatar: isEnabled
                            ? () => unawaited(_pickAvatar(cubit))
                            : null,
                        isEnabled: isEnabled,
                        validateName: AppValidators.name,
                        validatePhone: AppValidators.phone,
                        onResetPassword: () =>
                            unawaited(cubit.sendPasswordResetEmail()),
                        isSendingPasswordReset: state.isSendingPasswordReset,
                      ),
                    ),
                  ),
                  UpdateProfileActions(
                    isEnabled: isEnabled,
                    isDeleting: state.isDeleting,
                    isSaving: state.isSaving,

                    onDelete: () =>
                        unawaited(_confirmAndDelete(context, cubit)),

                    onSave: () => unawaited(cubit.saveProfile()),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    },
  );

  void _handleState(BuildContext context, UpdateProfileState state) {
    switch (state.action) {
      case UpdateProfileAction.profileLoaded:
      case UpdateProfileAction.none:
        break;
      case UpdateProfileAction.profileUpdated:
        AppSnackBar.show(
          message: tr.profileUpdatedSuccessfully,
          type: AppSnackBarType.success,
        );
        unawaited(context.router.maybePop());
      case UpdateProfileAction.passwordResetSent:
        AppSnackBar.show(
          message: tr.passwordResetEmailSent,
          type: AppSnackBarType.success,
        );
      case UpdateProfileAction.accountDeleted:
        unawaited(_navigateToSignInAfterFrame(context));
      case UpdateProfileAction.failed:
        final message = state.errorMessage;
        if (message != null) {
          AppSnackBar.show(
            message: localizedErrorMessage(context, message),
            type: AppSnackBarType.error,
          );
        }
    }
  }

  Future<void> _pickAvatar(UpdateProfileCubit cubit) async {
    final avatar = await PickAvatarBottomSheet.show(
      selectedAvatar:
          cubit.state.selectedAvatar ?? Avatar.profileImage1.avatar.path,
    );
    if (avatar != null) cubit.selectAvatar(avatar);
  }

  Future<void> _confirmAndDelete(
    BuildContext context,
    UpdateProfileCubit cubit,
  ) async {
    final confirmed = await _showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tr.deleteAccountConfirmTitle),
        content: Text(tr.deleteAccountConfirmMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text(tr.cancel),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: Text(tr.confirm),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    final requiresPassword = cubit.state.profile?.requiresPassword == true;
    final password = requiresPassword
        ? await _promptForPassword(context)
        : null;
    if (requiresPassword && (password == null || password.isEmpty)) return;
    if (!context.mounted) return;

    await cubit.deleteAccount(password: password);
  }

  Future<String?> _promptForPassword(BuildContext context) async {
    final passwordController = TextEditingController();
    try {
      return await _showDialog<String>(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(tr.deleteAccountConfirmTitle),
          content: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: InputDecoration(hintText: tr.password),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(tr.cancel),
            ),
            TextButton(
              onPressed: () =>
                  Navigator.of(context).pop(passwordController.text),
              child: Text(tr.confirm),
            ),
          ],
        ),
      );
    } finally {
      passwordController.dispose();
    }
  }

  Future<T?> _showDialog<T>({
    required BuildContext context,
    required WidgetBuilder builder,
  }) async {
    final navigator = Navigator.of(context, rootNavigator: true);
    final route = DialogRoute<T>(
      context: context,
      builder: builder,
      themes: InheritedTheme.capture(from: context, to: navigator.context),
    );
    final result = await navigator.push<T>(route);
    await route.completed;
    return result;
  }

  Future<void> _navigateToSignInAfterFrame(BuildContext context) async {
    await WidgetsBinding.instance.endOfFrame;
    if (!context.mounted) return;

    await context.router.replaceAll([const SignInRoute()]);
  }
}
