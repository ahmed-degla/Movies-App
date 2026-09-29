import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';
import 'package:movies/widgets/app_text_field.dart';

class SignInCredentials extends StatelessWidget {
  const SignInCredentials({
    required this.emailController,
    required this.passwordController,
    required this.validateEmail,
    required this.validatePassword,
    required this.onForgotPassword,
    required this.onSignIn,
    required this.isSignInDisabled,
    required this.isLoading,
    super.key,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final FormFieldValidator<String> validateEmail;
  final FormFieldValidator<String> validatePassword;
  final VoidCallback onForgotPassword;
  final VoidCallback? onSignIn;
  final bool isSignInDisabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      AppTextField(
        controller: emailController,
        hintText: tr.email,
        prefixIcon: UnconstrainedBox(
          child: Assets.images.svg.email.svg(width: 26.w, height: 26.h),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: validateEmail,
      ),
      SizedBox(height: 22.h),
      AppTextField(
        controller: passwordController,
        hintText: tr.password,
        prefixIcon: UnconstrainedBox(
          child: Assets.images.svg.lock.svg(width: 26.w, height: 26.h),
        ),
        obscureText: true,
        validator: validatePassword,
      ),
      SizedBox(height: 16.h),
      Align(
        alignment: AlignmentDirectional.centerEnd,
        child: AppText(
          onTap: onForgotPassword,
          text: tr.forgotPassword,
          color: appColors.primary,
        ),
      ),
      SizedBox(height: 30.h),
      AppButton(
        onTap: isSignInDisabled ? null : onSignIn,
        loading: isLoading,
        child: AppText(
          text: tr.login,
          fontSize: context.sp(20),
          color: appColors.background,
        ),
      ),
    ],
  );
}
