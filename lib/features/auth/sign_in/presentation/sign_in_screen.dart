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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        context.watch<GeneralCubit>();
        final cubit = SignInCubit.of(context);

        return Scaffold(
          body: SafeArea(
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 19),
              child: SingleChildScrollView(
                child: Form(
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      SizedBox(height: 67.h),
                      Assets.images.png.logo.image(width: 121.w, height: 118.h),
                      SizedBox(height: 69.h),
                      AppTextField(
                        controller: cubit.emailController,
                        hintText: tr.email,
                        prefixIcon: UnconstrainedBox(
                          child: Assets.images.svg.email.svg(
                            width: 31.w,
                            height: 25.h,
                          ),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => AppValidators.email(value),
                      ),

                      SizedBox(height: 22.h),
                      AppTextField(
                        controller: cubit.passwordController,
                        hintText: tr.password,
                        prefixIcon: UnconstrainedBox(
                          child: Assets.images.svg.lock.svg(
                            width: 26.w,
                            height: 30.h,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) => AppValidators.password(value),
                      ),
                      SizedBox(height: 17.h),
                      Row(
                        children: [
                          const Spacer(),
                          InkWell(
                            onTap: () async {
                              await context.router.push(
                                const ForgotPasswordRoute(),
                              );
                            },
                            child: AppText(
                              text: tr.forgotPassword,
                              color: appColors.primary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 33.h),
                      AppButton(
                        onTap: () async {
                          await cubit.signInWithEmail(
                            email: cubit.emailController.text,
                            password: cubit.passwordController.text,
                          );
                        },
                        loading: cubit.isStateLoading,
                        child: AppText(text: tr.login),
                      ),
                      SizedBox(height: 22.h),
                      Row(
                        spacing: 4.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: tr.dontHaveAccount,
                            color: appColors.primaryText,
                            fontSize: 14.sp,
                          ),
                          InkWell(
                            onTap: () async {
                              await context.router.push(const SignUpRoute());
                            },
                            child: AppText(
                              text: tr.createOne,
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
                            text: tr.or,
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
                      AppButton(
                        onTap: cubit.signInWithGoogle,
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
                              fontSize: 18.sp,
                              color: appColors.background,
                              fontWeight: FontWeight.w700,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 33.6.h),
                      CustomSwitch(),
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
