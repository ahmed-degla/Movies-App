import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/widgets/app_text.dart';

class ProfileTabItem extends StatelessWidget {
  const ProfileTabItem({
    required this.label,
    required this.iconPath,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  final String label;
  final String iconPath;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    overlayColor: .all(Colors.transparent),
    onTap: onTap,
    child: Column(
      children: [
        SvgPicture.asset(
          iconPath,
          width: context.w(22),
          height: context.h(22),
          colorFilter: ColorFilter.mode(appColors.primary, BlendMode.srcIn),
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
