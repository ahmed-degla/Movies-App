import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/widgets/app_text.dart';

class ProfileStatItem extends StatelessWidget {
  const ProfileStatItem({
    required this.value,
    required this.label,
    super.key,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      AppText(
        text: value,
        fontSize: context.sp(36),
        fontWeight: .w700,
      ),
      SizedBox(height: context.h(4)),
      AppText(
        text: label,
        color: colors.primaryText,
        fontSize: context.sp(20),
        fontWeight: .w700,
      ),
    ],
  );
}
