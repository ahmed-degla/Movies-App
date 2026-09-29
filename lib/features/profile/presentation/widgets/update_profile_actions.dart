import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/profile/presentation/widgets/reset_password_action.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';

class UpdateProfileActions extends StatelessWidget {
  const UpdateProfileActions({
    required this.isEnabled,
    required this.isDeleting,
    required this.isSaving,
    required this.onDelete,
    required this.onSave,
    super.key,
  });

  final bool isEnabled;
  final bool isDeleting;
  final bool isSaving;
  final VoidCallback onDelete;
  final VoidCallback onSave;

  @override
  Widget build(BuildContext context) {
    final strings = tr;
    return Column(
      children: [
        ResetPasswordAction(isEnabled: isEnabled),
        SizedBox(height: context.h(16)),
        AppButton(
          onTap: isEnabled ? onDelete : null,
          loading: isDeleting,
          backgroundColor: appColors.secondary,
          child: AppText(text: strings.deleteAccount, fontSize: context.sp(16)),
        ),
        SizedBox(height: context.h(16)),
        AppButton(
          onTap: isEnabled ? onSave : null,
          loading: isSaving,
          child: AppText(text: strings.updateData, fontSize: context.sp(16)),
        ),
        SizedBox(height: context.h(24)),
      ],
    );
  }
}
