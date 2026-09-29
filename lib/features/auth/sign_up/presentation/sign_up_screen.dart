import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart';
import 'package:movies/features/auth/sign_up/presentation/widgets/sign_up_avatar_picker.dart';
import 'package:movies/features/auth/sign_up/presentation/widgets/sign_up_form_fields.dart';
import 'package:movies/features/auth/widgets/custom_switch.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_back_button.dart';
import 'package:movies/widgets/app_bar.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_progress_indicator.dart';
import 'package:movies/widgets/app_snack_bar.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt.get<SignUpCubit>(),
    child: BlocConsumer<SignUpCubit, SignUpStates>(
      listener: (context, state) {
        if (state is SignUpSuccess) {
          unawaited(context.router.replaceAll([const HomeRoute()]));
        } else if (state is SignUpError) {
          AppSnackBar.show(
            message: localizedErrorMessage(context, state.message),
            type: AppSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final cubit = SignUpCubit.of(context);
        final isLoading = state is SignUpLoading;

        return Scaffold(
          appBar: AppAppBar(
            title: tr.register,
            titleColor: appColors.primary,

            leading: AppBackButton(
              child: UnconstrainedBox(
                child: Assets.images.svg.backArrow.svg(
                  width: 20.w,
                  height: 20.h,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      SignUpAvatarPicker(onAvatarSelected: cubit.selectAvatar),
                      SizedBox(height: 12.h),
                      SignUpFormFields(
                        nameController: cubit.nameController,
                        emailController: cubit.emailController,
                        passwordController: cubit.passwordController,
                        confirmPasswordController:
                            cubit.confirmPasswordController,
                        phoneController: cubit.phoneController,
                      ),
                      SizedBox(height: 24.h),
                      if (isLoading)
                        const Center(child: AppProgressIndicator())
                      else
                        AppButton(
                          onTap: () async {
                            await cubit.signUpWithEmail();
                          },
                          child: AppText(
                            text: tr.createAccount,
                            color: appColors.background,
                            fontSize: context.sp(20),
                          ),
                        ),
                      SizedBox(height: 16.h),
                      Row(
                        spacing: 4.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: tr.alreadyHaveAccount,
                            color: appColors.primaryText,
                            fontSize: 14.sp,
                          ),
                          AppText(
                            onTap: () => context.router.maybePop(),
                            text: tr.login,
                            color: appColors.primary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w900,
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),
                      const CustomSwitch(),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
