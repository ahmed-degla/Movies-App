import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
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
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.stretch,
    children: [
      SizedBox(height: context.h(16)),
      AppButton(
        onTap: isEnabled ? onDelete : null,
        loading: isDeleting,
        backgroundColor: appColors.secondary,
        child: AppText(text: tr.deleteAccount, fontSize: context.sp(20)),
      ),
      SizedBox(height: context.h(16)),
      AppButton(
        onTap: isEnabled ? onSave : null,
        loading: isSaving,
        child: AppText(
          text: tr.updateData,
          fontSize: context.sp(20),
          color: appColors.background,
        ),
      ),
      SizedBox(height: context.h(24)),
    ],
  );
}
