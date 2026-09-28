import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_text.dart';

class ProfileTabItem extends StatelessWidget {
  const ProfileTabItem({
    required this.label,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final SvgGenImage icon;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        overlayColor: .all(Colors.transparent),
        onTap: onTap,
        child: Column(
          children: [
            icon.svg(
              width: context.w(22),
              height: context.h(22),
              colorFilter: ColorFilter.mode(
                isSelected ? appColors.primary : appColors.primaryText,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(height: context.h(6)),
            AppText(
              text: label,
              fontSize: context.sp(20),
              color: isSelected ? appColors.primary : appColors.primaryText,
            ),
            SizedBox(height: context.h(10)),
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              height: context.h(3),
              width: double.infinity,
              color: isSelected ? appColors.primary : Colors.transparent,
            ),
          ],
        ),
      );
}
