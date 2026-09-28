import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/general_cubit/general_cubit.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/auth/sign_in/presentation/view_model/sign_in_cubit.dart';
import 'package:movies/features/auth/widgets/custom_switch.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';
import 'package:movies/widgets/app_text_field.dart';

@RoutePage()
class SignInScreen extends StatelessWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt.get<SignInCubit>(),
    child: BlocConsumer<SignInCubit, SignInStates>(
      listener: (context, state) {
        if (state is SignInSuccess) {
          unawaited(context.router.replaceAll([const HomeRoute()]));
        } else if (state is SignInError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        context.watch<GeneralCubit>();

        final cubit = SignInCubit.of(context);

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: context.edgeInsets(horizontal: 16),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 62.h),

                      Assets.images.png.logo.image(width: 120.w, height: 118.h),

                      SizedBox(height: 62.h),

                      AppTextField(
                        controller: cubit.emailController,
                        hintText: tr.email,
                        prefixIcon: UnconstrainedBox(
                          child: Assets.images.svg.email.svg(
                            width: 26.w,
                            height: 26.h,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: AppValidators.email,
                      ),

                      SizedBox(height: 22.h),

                      AppTextField(
                        controller: cubit.passwordController,
                        hintText: tr.password,
                        prefixIcon: UnconstrainedBox(
                          child: Assets.images.svg.lock.svg(
                            width: 26.w,
                            height: 26.h,
                          ),
                        ),
                        obscureText: true,
                        validator: AppValidators.password,
                      ),

                      SizedBox(height: 16.h),

                      Align(
                        alignment: AlignmentDirectional.centerEnd,
                        child: AppText(
                          onTap: () async {
                            await context.router.push(
                              const ForgotPasswordRoute(),
                            );
                          },
                          text: tr.forgotPassword,
                          color: appColors.primary,
                        ),
                      ),

                      SizedBox(height: 30.h),

                      AppButton(
                        onTap: cubit.isGoogleLoading
                            ? null
                            : cubit.signInWithEmail,
                        loading: cubit.isEmailLoading,
                        child: AppText(
                          text: tr.login,
                          fontSize: context.sp(20),
                          color: appColors.background,
                        ),
                      ),

                      SizedBox(height: 20.h),

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
                            onTap: () async {
                              await context.router.push(const SignUpRoute());
                            },
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
                          AppText(
                            text: tr.or,
                            color: appColors.primary,
                            fontSize: 15.sp,
                          ),
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
                        onTap: cubit.isEmailLoading
                            ? null
                            : cubit.signInWithGoogle,
                        loading: cubit.isGoogleLoading,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Assets.images.svg.iconGoogle.svg(
                              height: 26.h,
                              width: 26.w,
                            ),
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
