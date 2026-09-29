import 'package:flutter/material.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/widgets/app_text.dart';

class ResetPasswordAction extends StatelessWidget {
  const ResetPasswordAction({
    required this.isEnabled,
    required this.isLoading,
    required this.onTap,
    super.key,
  });

  final bool isEnabled;
  final bool isLoading;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => AppText(
    text: tr.resetPassword,
    color: appColors.primary,
    onTap: isEnabled && !isLoading ? onTap : null,
  );
}
