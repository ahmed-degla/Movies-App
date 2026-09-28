import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/enum/profile_avatar.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart';
import 'package:movies/features/auth/widgets/custom_switch.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_back_button.dart';
import 'package:movies/widgets/app_bar.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';
import 'package:movies/widgets/app_text_field.dart';

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
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
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
                      CarouselSlider.builder(
                        options: CarouselOptions(
                          height: 160.h,
                          enlargeCenterPage: true,
                          enlargeFactor: 0.5,
                          viewportFraction: 0.3,
                          onPageChanged: (index, _) {
                            cubit.selectAvatar(index);
                          },
                        ),

                        itemCount: Avatar.values.length,
                        itemBuilder:
                            (BuildContext context, int index, int realIndex) =>
                                Avatar.values[index].avatar.image(
                                  width: 160.w,
                                  height: 160.h,
                                ),
                      ),
                      AppText(text: tr.avatar, fontSize: 16.sp),
                      SizedBox(height: 12.h),
                      AppTextField(
                        controller: cubit.nameController,
                        hintText: tr.name,
                        prefixIcon: UnconstrainedBox(
                          child: Assets.images.svg.nameIcon.svg(
                            width: 26.w,
                            height: 26.h,
                          ),
                        ),
                        validator: (value) => AppValidators.name(value),
                      ),
                      SizedBox(height: 24.h),
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
                        validator: (value) => AppValidators.email(value),
                      ),
                      SizedBox(height: 24.h),
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
                        validator: (value) => AppValidators.password(value),
                      ),
                      SizedBox(height: 24.h),
                      AppTextField(
                        controller: cubit.confirmPasswordController,
                        hintText: tr.confirmPassword,
                        prefixIcon: UnconstrainedBox(
                          child: Assets.images.svg.lock.svg(
                            width: 26.w,
                            height: 26.h,
                          ),
                        ),
                        obscureText: true,
                        validator: (value) => AppValidators.confirmPassword(
                          value,
                          cubit.passwordController.text,
                        ),
                      ),
                      SizedBox(height: 24.h),
                      AppTextField(
                        controller: cubit.phoneController,
                        hintText: tr.phoneNumber,
                        prefixIcon: UnconstrainedBox(
                          child: Assets.images.svg.phone.svg(
                            width: 26.w,
                            height: 26.h,
                          ),
                        ),
                        keyboardType: TextInputType.phone,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                          LengthLimitingTextInputFormatter(11),
                        ],
                        validator: (value) => AppValidators.phone(value),
                      ),
                      SizedBox(height: 24.h),
                      if (isLoading)
                        const Center(child: CircularProgressIndicator())
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
