import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import '../core/routing/app_router.dart';

enum AppSnackBarType { success, error, info, warning }

class AppSnackBar {
  AppSnackBar._();

  static void show({
    required String message,
    AppSnackBarType type = AppSnackBarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    final context = AppRouter.instance.navigatorKey.currentContext!;
    final messenger = ScaffoldMessenger.of(context);

    messenger
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(_icon(type), color: Colors.white),
               SizedBox(width: context.w(12)),
              Expanded(
                child: Text(
                  message,
                  style:  TextStyle(
                    color: Colors.white,
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          duration: duration,
          behavior: SnackBarBehavior.floating,
          margin:  EdgeInsets.all(context.w(16)),
          padding:  EdgeInsets.symmetric(horizontal: context.w(16), vertical: context.h(14)),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: _backgroundColor(type),
        ),
      );
  }

  static IconData _icon(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return Icons.check_circle_outline;

      case AppSnackBarType.error:
        return Icons.error_outline;

      case AppSnackBarType.warning:
        return Icons.warning_amber_outlined;

      case AppSnackBarType.info:
        return Icons.info_outline;
    }
  }

  static Color _backgroundColor(AppSnackBarType type) {
    switch (type) {
      case AppSnackBarType.success:
        return Colors.green;

      case AppSnackBarType.error:
        return Colors.red;

      case AppSnackBarType.warning:
        return Colors.orange;

      case AppSnackBarType.info:
        return Colors.blue;
    }
  }
}
