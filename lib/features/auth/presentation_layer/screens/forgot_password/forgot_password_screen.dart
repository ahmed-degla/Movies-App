import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/auth/presentation_layer/widgets/custom_button.dart';
import 'package:movies/features/auth/presentation_layer/widgets/custom_field.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/generated/l10n/app_localizations.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
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
              text: AppLocalizations.of(context)!.forgotPassword,
            color: appColors.primary,
            fontSize: 16.sp,
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16.w),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 24.h,
                children: [
                  Assets.images.png.forgotPassword.image(
                    height: 430.h,
                    fit: BoxFit.fitHeight,
                  ),
                  CustomField(
                    controller: _emailController,
                    prefix: Assets.images.svg.email.svg(width: 31.w, height: 25.h),
                    hintText: AppLocalizations.of(context)!.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => AppValidators.email(value),
                  ),
                  CustomButton(
                    title: AppLocalizations.of(context)!.verifyEmail,
                    onTap: () {
                      if (_formKey.currentState!.validate()) {
                        // Handle verification logic
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      );
}
