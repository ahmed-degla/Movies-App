import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/auth/presentation_layer/widgets/custom_button.dart';
import 'package:movies/features/auth/presentation_layer/widgets/custom_field.dart';
import 'package:movies/features/auth/presentation_layer/widgets/custom_switch.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/generated/l10n/app_localizations.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  bool _isEnglish = true;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: InkWell(
            onTap: () => context.router.pop(),
            child: Padding(
              padding: REdgeInsets.all(16),
              child: Assets.images.svg.backArrow.svg(
                width: 24.w,
                height: 24.h,
              ),
            ),
          ),
          title: AppText(
            text: AppLocalizations.of(context)!.register,
            color: appColors.primary,
            fontSize: 16.sp,
          ),
          centerTitle: true,
        ),
        body: SafeArea(
          child: Padding(
            padding: REdgeInsets.symmetric(horizontal: 19),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                        height: 161.h,
                        enlargeCenterPage: true,
                        enlargeFactor: 0.5,
                        viewportFraction: 0.3,
                      ),
                      items: [
                        Assets.images.png.avatar1,
                        Assets.images.png.avatar2,
                        Assets.images.png.avatar3,
                        Assets.images.png.avatar4,
                        Assets.images.png.avatar5,
                        Assets.images.png.avatar6,
                        Assets.images.png.avatar7,
                        Assets.images.png.avatar8,
                        Assets.images.png.avatar9,
                      ]
                          .map((avatar) =>
                              avatar.image(width: 161.w, height: 161.h))
                          .toList(),
                    ),
                    AppText(
                      text: AppLocalizations.of(context)!.avatar,
                      color: appColors.primaryText,
                      fontSize: 16.sp,
                    ),
                    SizedBox(height: 12.h),
                    CustomField(
                      controller: _nameController,
                      hintText: AppLocalizations.of(context)!.name,
                      prefix: Assets.images.svg.nameIcon.svg(
                        width: 37.w,
                        height: 36.h,
                      ),
                      validator: (value) => AppValidators.name(value),
                    ),
                    SizedBox(height: 24.h),
                    CustomField(
                      controller: _emailController,
                      hintText: AppLocalizations.of(context)!.email,
                      prefix: Assets.images.svg.email.svg(
                        width: 31.w,
                        height: 25.h,
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => AppValidators.email(value),
                    ),
                    SizedBox(height: 24.h),
                    CustomField(
                      controller: _passwordController,
                      hintText: AppLocalizations.of(context)!.password,
                      prefix: Assets.images.svg.lock.svg(
                        width: 26.w,
                        height: 30.h,
                      ),
                      isPassword: true,
                      validator: (value) => AppValidators.password(value),
                    ),
                    SizedBox(height: 24.h),
                    CustomField(
                      controller: _confirmPasswordController,
                      hintText: AppLocalizations.of(context)!.confirmPassword,
                      prefix: Assets.images.svg.lock.svg(
                        width: 26.w,
                        height: 30.h,
                      ),
                      isPassword: true,
                      validator: (value) => AppValidators.confirmPassword(
                        value,
                        _passwordController.text,
                      ),
                    ),
                    SizedBox(height: 24.h),
                    CustomField(
                      controller: _phoneController,
                      hintText: AppLocalizations.of(context)!.phoneNumber,
                      prefix: Assets.images.svg.phone.svg(
                        width: 25.w,
                        height: 25.h,
                      ),
                      keyboardType: TextInputType.phone,
                      validator: (value) => AppValidators.phone(value),
                    ),
                    SizedBox(height: 24.h),
                    CustomButton(
                      title: AppLocalizations.of(context)!.createAccount,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          // Handle Registration
                        }
                      },
                    ),
                    SizedBox(height: 17.h),
                    Row(
                      spacing: 4.w,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText(
                          text: AppLocalizations.of(context)!.alreadyHaveAccount,
                          color: appColors.primaryText,
                          fontSize: 14.sp,
                        ),
                        InkWell(
                          onTap: () => context.router.pop(),
                          child: AppText(
                            text: AppLocalizations.of(context)!.login,
                            color: appColors.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 18.h),
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
