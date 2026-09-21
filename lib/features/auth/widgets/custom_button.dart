import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/generated/assets/assets.gen.dart' show Assets;
import 'package:movies/widgets/app_text.dart';

class CustomButton extends StatelessWidget {
  final String title;
  final bool? isGoogleLogin;
  final VoidCallback? onTap;

  const CustomButton({
    super.key,
    required this.title,
    this.isGoogleLogin = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.r),
          child: Container(
            color: appColors.primary,
            width: double.infinity,
            height: 56.h,
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (isGoogleLogin == true) ...[
                    Assets.images.svg.iconGoogle.svg(height: 26.h, width: 26.w),
                    SizedBox(width: 11.w),
                  ],
                  AppText(
                    text: title,
                    fontSize: 20.sp,
                    color: appColors.background,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
