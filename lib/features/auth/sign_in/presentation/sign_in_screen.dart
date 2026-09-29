import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/general_cubit/general_cubit.dart';
import 'package:movies/core/helpers/app_validator.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/auth/sign_in/presentation/view_model/sign_in_cubit.dart';
import 'package:movies/features/auth/sign_in/presentation/widgets/sign_in_alternatives.dart';
import 'package:movies/features/auth/sign_in/presentation/widgets/sign_in_credentials.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_snack_bar.dart';

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
          AppSnackBar.show(
            message: localizedErrorMessage(context, state.message),
            type: AppSnackBarType.error,
          );
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

                      SignInCredentials(
                        emailController: cubit.emailController,
                        passwordController: cubit.passwordController,
                        validateEmail: (value) =>
                            AppValidators.email(value, tr),
                        validatePassword: (value) =>
                            AppValidators.password(value, tr),
                        onForgotPassword: () async {
                          await context.router.push(
                            const ForgotPasswordRoute(),
                          );
                        },
                        onSignIn: cubit.signInWithEmail,
                        isSignInDisabled: cubit.isGoogleLoading,
                        isLoading: cubit.isEmailLoading,
                      ),
                      SizedBox(height: 20.h),
                      SignInAlternatives(
                        onCreateAccount: () async {
                          await context.router.push(const SignUpRoute());
                        },
                        onGoogleSignIn: cubit.signInWithGoogle,
                        isGoogleSignInDisabled: cubit.isEmailLoading,
                        isGoogleLoading: cubit.isGoogleLoading,
                      ),
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
