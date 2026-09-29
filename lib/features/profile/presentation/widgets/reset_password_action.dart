import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/widgets/app_progress_indicator.dart';
import 'package:movies/widgets/app_snack_bar.dart';
import 'package:movies/widgets/app_text.dart';

class ResetPasswordAction extends StatefulWidget {
  const ResetPasswordAction({required this.isEnabled, super.key});

  final bool isEnabled;

  @override
  State<ResetPasswordAction> createState() => _ResetPasswordActionState();
}

class _ResetPasswordActionState extends State<ResetPasswordAction> {
  bool _isLoading = false;

  Future<void> _sendResetEmail() async {
    final email = getIt.get<FirebaseAuthService>().currentUser?.email;
    if (email == null || email.isEmpty) {
      _showMessage(tr.requestFailed);
      return;
    }

    setState(() => _isLoading = true);
    try {
      await getIt.get<FirebaseAuthService>().sendPasswordResetEmail(
        email: email,
      );
      if (mounted) {
        _showMessage(tr.passwordResetEmailSent, type: AppSnackBarType.success);
      }
    } on FirebaseAuthException catch (error) {
      if (mounted) {
        _showMessage(localizedErrorMessage(context, error.code));
      }
    } on Object catch (error) {
      if (mounted) {
        _showMessage(localizedErrorMessage(context, error.toString()));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showMessage(
    String message, {
    AppSnackBarType type = AppSnackBarType.error,
  }) {
    AppSnackBar.show(message: message, type: type);
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(child: AppProgressIndicator());
    }

    return AppText(
      text: tr.resetPassword,
      color: appColors.primary,
      onTap: widget.isEnabled ? () => unawaited(_sendResetEmail()) : null,
    );
  }
}
