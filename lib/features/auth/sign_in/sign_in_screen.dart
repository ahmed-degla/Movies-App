import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/auth/widgets/custom_button.dart';
import 'package:movies/features/auth/widgets/custom_field.dart';
import 'package:movies/features/auth/widgets/custom_switch.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/generated/l10n/app_localizations.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  bool _isEnglish = true;
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
      body: SafeArea(
        child: Padding(
          padding: REdgeInsets.symmetric(horizontal: 19),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 67.h),
                  Assets.images.png.logo.image(width: 121.w, height: 118.h),
                  SizedBox(height: 69.h),
                  CustomField(
                    controller: _emailController,
                    hintText: AppLocalizations.of(context)!.email,
                    prefix: Assets.images.svg.email.svg(width: 31.w, height: 25.h),
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => AppValidators.email(value),
                  ),
                  SizedBox(height: 22.h),
                  CustomField(
                    controller: _passwordController,
                    hintText: AppLocalizations.of(context)!.password,
                    prefix: Assets.images.svg.lock.svg(width: 26.w, height: 30.h),
                    isPassword: true,
                    validator: (value) => AppValidators.password(value),
                  ),
                  SizedBox(height: 17.h),
                  Row(
                    children: [
                      const Spacer(),
                      InkWell(
                        onTap: () async {
                          await context.router.push(const ForgotPasswordRoute());
                        },
                        child: AppText(
                          text: AppLocalizations.of(context)!.forgotPassword,
                          color: appColors.primary,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 33.h),
                  CustomButton(
                    title: AppLocalizations.of(context)!.login,
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        await context.router.push(const HomeRoute());
                      }
                    },
                  ),
                  SizedBox(height: 22.h),
                  Row(
                    spacing: 4.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText(
                        text: AppLocalizations.of(context)!.dontHaveAccount,
                        color: appColors.primaryText,
                        fontSize: 14.sp,
                      ),
                      InkWell(
                        onTap: () async {
                          await context.router.push(const SignUpRoute());
                        },
                        child: AppText(
                          text: AppLocalizations.of(context)!.createOne,
                          color: appColors.primary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 27.h),
                  Row(
                    spacing: 11.w,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 91.w,
                        child: Divider(
                          height: 1.h,
                          thickness: 1.h,
                          color: appColors.primary,
                        ),
                      ),
                      AppText(
                        text: AppLocalizations.of(context)!.or,
                        color: appColors.primary,
                        fontSize: 15.sp,
                      ),
                      SizedBox(
                        width: 91.w,
                        child: Divider(
                          height: 1.h,
                          thickness: 1.h,
                          color: appColors.primary,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 28.h),
                  CustomButton(
                    title: AppLocalizations.of(context)!.loginWithGoogle,
                    isGoogleLogin: true,
                    onTap: () {
                      // Handle Google Login
                    },
                  ),
                  SizedBox(height: 33.6.h),
                  CustomSwitch(
                    initialIsEnglish: _isEnglish,
                    onChanged: (value) {
                      setState(() {
                        _isEnglish = value;
                      });
                    },
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
}
