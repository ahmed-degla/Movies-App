import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/auth/forgot_password/presentation/view_model/forgot_password_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_back_button.dart';
import 'package:movies/widgets/app_bar.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_snack_bar.dart';
import 'package:movies/widgets/app_text.dart';
import 'package:movies/widgets/app_text_field.dart';

@RoutePage()
class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt.get<ForgotPasswordCubit>(),
    child: BlocConsumer<ForgotPasswordCubit, ForgotPasswordStates>(
      listener: (context, state) {
        if (state is ForgotPasswordSuccess) {
          AppSnackBar.show(message: tr.passwordResetEmailSent);
          unawaited(context.router.maybePop());
        } else if (state is ForgotPasswordError) {
          AppSnackBar.show(
            message: localizedErrorMessage(context, state.message),
            type: AppSnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        final cubit = ForgotPasswordCubit.of(context);
        final isLoading = state is ForgotPasswordLoading;

        return Scaffold(
          appBar: AppAppBar(
            title: tr.forgotPassword,
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

          body: Padding(
            padding: REdgeInsets.symmetric(horizontal: 16.w),
            child: SingleChildScrollView(
              child: Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: .stretch,
                  spacing: 24.h,
                  children: [
                    Assets.images.png.forgotPassword.image(fit: BoxFit.cover),
                    AppTextField(
                      controller: cubit.emailController,
                      prefixIcon: UnconstrainedBox(
                        child: Assets.images.svg.email.svg(
                          width: 26.w,
                          height: 26.h,
                        ),
                      ),
                      hintText: tr.email,
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => AppValidators.email(value, tr),
                    ),

                    AppButton(
                      onTap: () async {
                        if (cubit.formKey.currentState!.validate()) {
                          await cubit.sendPasswordResetEmail(
                            email: cubit.emailController.text,
                          );
                        }
                      },
                      loading: isLoading,
                      child: AppText(
                        text: tr.verifyEmail,
                        fontSize: context.sp(20),
                        color: appColors.background,
                      ),
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
