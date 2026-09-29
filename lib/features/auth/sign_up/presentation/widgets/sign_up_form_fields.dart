import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_text_field.dart';

class SignUpFormFields extends StatelessWidget {
  const SignUpFormFields({
    required this.nameController,
    required this.emailController,
    required this.passwordController,
    required this.confirmPasswordController,
    required this.phoneController,
    super.key,
  });

  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      AppTextField(
        controller: nameController,
        hintText: tr.name,
        prefixIcon: UnconstrainedBox(
          child: Assets.images.svg.nameIcon.svg(width: 26.w, height: 26.h),
        ),
        validator: (value) => AppValidators.name(value),
      ),
      SizedBox(height: 24.h),
      AppTextField(
        controller: emailController,
        hintText: tr.email,
        prefixIcon: UnconstrainedBox(
          child: Assets.images.svg.email.svg(width: 26.w, height: 26.h),
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => AppValidators.email(value),
      ),
      SizedBox(height: 24.h),
      AppTextField(
        controller: passwordController,
        hintText: tr.password,
        prefixIcon: UnconstrainedBox(
          child: Assets.images.svg.lock.svg(width: 26.w, height: 26.h),
        ),
        obscureText: true,
        validator: (value) => AppValidators.password(value),
      ),
      SizedBox(height: 24.h),
      AppTextField(
        controller: confirmPasswordController,
        hintText: tr.confirmPassword,
        prefixIcon: UnconstrainedBox(
          child: Assets.images.svg.lock.svg(width: 26.w, height: 26.h),
        ),
        obscureText: true,
        validator: (value) =>
            AppValidators.confirmPassword(value, passwordController.text),
      ),
      SizedBox(height: 24.h),
      AppTextField(
        controller: phoneController,
        hintText: tr.phoneNumber,
        prefixIcon: UnconstrainedBox(
          child: Assets.images.svg.phone.svg(width: 26.w, height: 26.h),
        ),
        keyboardType: TextInputType.phone,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(11),
        ],
        validator: (value) => AppValidators.phone(value),
      ),
    ],
  );
}
