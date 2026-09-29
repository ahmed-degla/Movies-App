import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/widgets/app_progress_indicator.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    required this.onTap,
    required this.child,
    super.key,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.gradient,
    this.enableGradient = false,
    this.borderRadius,
    this.border,
    this.elevation = 0,
    this.shadowColor,
    this.overlayColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.alignment,
    this.iconAlignment,
    this.clipBehavior = Clip.antiAlias,
    this.loading = false,
    this.loadingWidget,
    this.prefix,
    this.suffix,
    this.textStyle,
  }) : _outlined = false;

  const AppButton.outlined({
    required this.onTap,
    required this.child,
    super.key,
    this.width,
    this.height,
    this.padding,
    this.backgroundColor,
    this.foregroundColor,
    this.gradient,
    this.enableGradient = false,
    this.borderRadius,
    this.border,
    this.elevation = 0,
    this.shadowColor,
    this.overlayColor,
    this.disabledBackgroundColor,
    this.disabledForegroundColor,
    this.minimumSize,
    this.maximumSize,
    this.fixedSize,
    this.alignment,
    this.iconAlignment,
    this.clipBehavior = Clip.antiAlias,
    this.loading = false,
    this.loadingWidget,
    this.prefix,
    this.suffix,
    this.textStyle,
  }) : _outlined = true;

  final VoidCallback? onTap;
  final Widget child;

  final double? width;
  final double? height;

  final EdgeInsetsGeometry? padding;

  final Color? backgroundColor;
  final Color? foregroundColor;

  final Gradient? gradient;
  final bool enableGradient;

  final double? borderRadius;
  final BorderSide? border;

  final double elevation;
  final Color? shadowColor;

  final Color? overlayColor;

  final Color? disabledBackgroundColor;
  final Color? disabledForegroundColor;

  final Size? minimumSize;
  final Size? maximumSize;
  final Size? fixedSize;

  final AlignmentGeometry? alignment;
  final IconAlignment? iconAlignment;

  final Clip clipBehavior;

  final bool loading;
  final Widget? loadingWidget;

  final Widget? prefix;
  final Widget? suffix;

  final TextStyle? textStyle;

  final bool _outlined;

  @override
  @override
  Widget build(BuildContext context) {
    final primaryColor = backgroundColor ?? appColors.primary;

    final textColor = foregroundColor ?? appColors.primaryText;

    final radius = borderRadius ?? context.sp(16);

    final effectiveBorder = _outlined
        ? border ?? BorderSide(color: primaryColor, width: context.w(1.5))
        : border;

    final useGradient = enableGradient && backgroundColor == null && !_outlined;

    final button = ElevatedButton(

      onPressed: loading ? null : onTap,
      style: ElevatedButton.styleFrom(
        backgroundColor: useGradient
            ? Colors.transparent
            : _outlined
            ? Colors.transparent
            : primaryColor,

        foregroundColor: textColor,

        disabledBackgroundColor: useGradient
            ? Colors.transparent
            : disabledBackgroundColor,

        disabledForegroundColor: disabledForegroundColor,

        elevation: useGradient ? 0 : elevation,

        shadowColor: shadowColor,

        padding: padding,

        minimumSize: minimumSize,

        maximumSize: maximumSize,

        fixedSize:
            fixedSize ?? Size(width ?? double.infinity, height ?? context.h(50)),

        alignment: alignment,

        iconAlignment: iconAlignment,

        overlayColor: overlayColor,

        textStyle: textStyle,

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: effectiveBorder ?? BorderSide.none,
        ),
      ),

      child: _buildChild(context, textColor),
    );

    if (!useGradient) {
      return button;
    }

    return Container(
      width: width ?? context.w(358),
      height: height ?? context.h(50),

      decoration: BoxDecoration(
        gradient: gradient ?? const LinearGradient(colors: []),
        borderRadius: BorderRadius.circular(radius),
      ),

      clipBehavior: clipBehavior,

      child: button,
    );
  }

  Widget _buildChild(BuildContext context, Color color) {
    if (loading) {
      return loadingWidget ??
          AppProgressIndicator(
            size: context.w(22),
            strokeWidth: context.w(2.5),
            color: color,
          );
    }

    if (prefix == null && suffix == null) {
      return child;
    }

    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (prefix != null) ...[prefix!, SizedBox(width: context.w(8))],
        Flexible(child: child),
        if (suffix != null) ...[SizedBox(width: context.w(8)), suffix!],
      ],
    );
  }
}
