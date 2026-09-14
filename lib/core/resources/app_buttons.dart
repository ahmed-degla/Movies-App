import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';

class AppPrimaryButton extends StatelessWidget {
  const AppPrimaryButton({
    required this.onTap,
    super.key,
    this.title,
    this.child,
    this.prefix,
    this.suffix,
    this.height,
  });

  final VoidCallback? onTap;
  final String? title;
  final Widget? child;
  final Widget? prefix;
  final Widget? suffix;
  final double? height;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => AppButton(
      onTap: onTap,
      width: constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : context.w(358),
      height: height ?? context.h(50),
      backgroundColor: colors.primary,
      foregroundColor: colors.background,
      prefix: prefix,
      suffix: suffix,
      child:
          child ??
          AppText(
            text: title ?? '',
            color: colors.background,
            fontSize: context.sp(20),
          ),
    ),
  );
}

class AppDangerButton extends StatelessWidget {
  const AppDangerButton({
    required this.onTap,
    super.key,
    this.title,
    this.child,
    this.prefix,
    this.suffix,
    this.height,
  });

  final VoidCallback? onTap;
  final String? title;
  final Widget? child;
  final Widget? prefix;
  final Widget? suffix;
  final double? height;

  @override
  Widget build(BuildContext context) => LayoutBuilder(
    builder: (context, constraints) => AppButton(
      onTap: onTap,
      width: constraints.maxWidth.isFinite
          ? constraints.maxWidth
          : context.w(358),
      height: height ?? context.h(50),
      backgroundColor: colors.secondary,
      foregroundColor: colors.primaryText,
      prefix: prefix,
      suffix: suffix,
      child:
          child ??
          AppText(
            text: title ?? '',
            color: colors.primaryText,
            fontSize: context.sp(20),
          ),
    ),
  );
}
