import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart';
import 'package:movies/features/auth/widgets/custom_button.dart';
import 'package:movies/features/auth/widgets/custom_field.dart';
import 'package:movies/features/auth/widgets/custom_switch.dart';
import 'package:movies/generated/assets/assets.gen.dart';
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
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final cubit = SignUpCubit.of(context);
        final isLoading = state is SignUpLoading;

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: InkWell(
              onTap: () => context.router.maybePop(),
              child: Padding(
                padding: REdgeInsets.all(16),
                child: Assets.images.svg.backArrow.svg(
                  width: 24.w,
                  height: 24.h,
                ),
              ),
            ),
            title: AppText(
              text: tr.register,
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
                  key: cubit.formKey,
                  child: Column(
                    children: [
                      CarouselSlider(
                        options: CarouselOptions(
                          height: 161.h,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.5,
                          viewportFraction: 0.3,
                          onPageChanged: (index, _) {
                            cubit.selectAvatar(index);
                          },
                        ),
                        items: cubit.avatars
                            .map(
                              (avatar) =>
                                  avatar.image(width: 161.w, height: 161.h),
                            )
                            .toList(),
                      ),
                      AppText(
                        text: tr.avatar,
                        color: appColors.primaryText,
                        fontSize: 16.sp,
                      ),
                      SizedBox(height: 12.h),
                      CustomField(
                        controller: cubit.nameController,
                        hintText: tr.name,
                        prefix: Assets.images.svg.nameIcon.svg(
                          width: 37.w,
                          height: 36.h,
                        ),
                        validator: (value) => AppValidators.name(value),
                      ),
                      SizedBox(height: 24.h),
                      CustomField(
                        controller: cubit.emailController,
                        hintText: tr.email,
                        prefix: Assets.images.svg.email.svg(
                          width: 31.w,
                          height: 25.h,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) => AppValidators.email(value),
                      ),
                      SizedBox(height: 24.h),
                      CustomField(
                        controller: cubit.passwordController,
                        hintText: tr.password,
                        prefix: Assets.images.svg.lock.svg(
                          width: 26.w,
                          height: 30.h,
                        ),
                        isPassword: true,
                        validator: (value) => AppValidators.password(value),
                      ),
                      SizedBox(height: 24.h),
                      CustomField(
                        controller: cubit.confirmPasswordController,
                        hintText: tr.confirmPassword,
                        prefix: Assets.images.svg.lock.svg(
                          width: 26.w,
                          height: 30.h,
                        ),
                        isPassword: true,
                        validator: (value) => AppValidators.confirmPassword(
                          value,
                          cubit.passwordController.text,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      CustomField(
                        controller: cubit.phoneController,
                        hintText: tr.phoneNumber,
                        prefix: Assets.images.svg.phone.svg(
                          width: 25.w,
                          height: 25.h,
                        ),
                        keyboardType: TextInputType.phone,
                        validator: (value) => AppValidators.phone(value),
                      ),
                      SizedBox(height: 24.h),
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
                      else
                        CustomButton(
                          title: tr.createAccount,
                          onTap: () async {
                            if (cubit.formKey.currentState!.validate()) {
                              await cubit.signUpWithEmail(
                                email: cubit.emailController.text,
                                password: cubit.passwordController.text,
                                name: cubit.nameController.text,
                                phone: cubit.phoneController.text,
                                avatar: cubit
                                    .avatars[cubit.selectedAvatarIndex]
                                    .path,
                              );
                            }
                          },
                        ),
                      SizedBox(height: 17.h),
                      Row(
                        spacing: 4.w,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppText(
                            text: tr.alreadyHaveAccount,
                            color: appColors.primaryText,
                            fontSize: 14.sp,
                          ),
                          InkWell(
                            onTap: () => context.router.maybePop(),
                            child: AppText(
                              text: tr.login,
                              color: appColors.primary,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 18.h),
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
