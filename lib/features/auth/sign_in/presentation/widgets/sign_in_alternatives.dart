import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/auth/widgets/custom_switch.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';

class SignInAlternatives extends StatelessWidget {
  const SignInAlternatives({
    required this.onCreateAccount,
    required this.onGoogleSignIn,
    required this.isGoogleSignInDisabled,
    required this.isGoogleLoading,
    super.key,
  });

  final VoidCallback onCreateAccount;
  final VoidCallback? onGoogleSignIn;
  final bool isGoogleSignInDisabled;
  final bool isGoogleLoading;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Row(
        spacing: 4.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AppText(
            text: tr.dontHaveAccount,
            color: appColors.primaryText,
            fontSize: 14.sp,
          ),
          AppText(
            onTap: onCreateAccount,
            text: tr.createOne,
            color: appColors.primary,
            fontSize: 14.sp,
            fontWeight: FontWeight.w900,
          ),
        ],
      ),
      SizedBox(height: 26.h),
      Row(
        spacing: 12.w,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Divider(
              height: 1.h,
              thickness: 1.h,
              color: appColors.primary,
              indent: context.w(30),
            ),
          ),
          AppText(text: tr.or, color: appColors.primary, fontSize: 15.sp),
          Expanded(
            child: Divider(
              height: 1.h,
              thickness: 1.h,
              color: appColors.primary,
              endIndent: context.w(30),
            ),
          ),
        ],
      ),
      SizedBox(height: 28.h),
      AppButton(
        onTap: isGoogleSignInDisabled ? null : onGoogleSignIn,
        loading: isGoogleLoading,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Assets.images.svg.iconGoogle.svg(height: 26.h, width: 26.w),
            SizedBox(width: 10.w),
            AppText(
              text: tr.loginWithGoogle,
              fontSize: 16.sp,
              color: appColors.background,
            ),
          ],
        ),
      ),
      SizedBox(height: 20.h),
      const CustomSwitch(),
    ],
  );
}
