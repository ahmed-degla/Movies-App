import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/auth/forgot_password/presentation/view_model/forgot_password_cubit.dart';
import 'package:movies/features/auth/widgets/custom_button.dart';
import 'package:movies/features/auth/widgets/custom_field.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_bar.dart';
import 'package:movies/widgets/app_snack_bar.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt.get<ForgotPasswordCubit>(),
    child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          AppSnackBar.show(
            message: 'Password reset link sent! Please check your email.',
          );
          unawaited(context.router.maybePop());
        } else if (state is ForgotPasswordError) {
          AppSnackBar.show(message: state.message, type: AppSnackBarType.error);
        }
      },
      builder: (context, state) {
        final cubit = ForgotPasswordCubit.of(context);
        final isLoading = state is ForgotPasswordLoading;

        return Scaffold(
          appBar: AppAppBar(
            title: tr.forgotPassword,
          ),
          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  spacing: 24.h,
                  children: [
                    Assets.images.png.forgotPassword.image(
                      height: 430.h,
                      fit: BoxFit.fitHeight,
                    ),
                    CustomField(
                      controller: cubit.emailController,
                      prefix: Assets.images.svg.email.svg(
                        width: 31.w,
                        height: 25.h,
                      ),
                      hintText: tr.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => AppValidators.email(value),
                    ),
                    if (isLoading)
                      const Center(child: CircularProgressIndicator())
                    else
                      CustomButton(
                        title: tr.verifyEmail,
                        onTap: () async {
                          if (cubit.formKey.currentState!.validate()) {
                            await cubit.sendPasswordResetEmail(
                              email: cubit.emailController.text,
                            );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    ),
  );
}
