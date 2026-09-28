import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_text.dart';

class StatChip extends StatelessWidget {
  const StatChip({
    required this.icon,
    required this.value,
    super.key,
  });

  final SvgGenImage icon;
  final String value;

  @override
  Widget build(BuildContext context) => Container(
        height: context.h(48),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: appColors.fill,
          borderRadius: BorderRadius.circular(context.r(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            icon.svg(
              width: context.w(22),
              height: context.w(22),
            ),
            SizedBox(width: context.w(8)),
            Flexible(
              child: AppText(
                text: value,
                fontSize: context.sp(16),
                fontWeight: FontWeight.bold,
                color: appColors.primaryText,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      );
}
