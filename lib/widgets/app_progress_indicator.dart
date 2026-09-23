import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';

class AppProgressIndicator extends StatelessWidget {
  const AppProgressIndicator({
    super.key,
    this.size,
    this.strokeWidth,
    this.color,
  });

  final double? size;
  final double? strokeWidth;
  final Color? color;

  @override
  Widget build(BuildContext context) => SizedBox(
      width: size ?? context.w(32),
      height: size ?? context.w(32),
      child: CircularProgressIndicator(
        strokeWidth: strokeWidth,
        valueColor: AlwaysStoppedAnimation<Color>(color ?? appColors.primary),
      ),
    );
}
