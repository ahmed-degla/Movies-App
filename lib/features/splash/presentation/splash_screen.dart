import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/onboarding/domain/use_cases/is_onboarding_completed_use_case.dart';
import 'package:movies/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final cubit = SplashCubit(
        isAuthenticated: () => getIt<FirebaseAuthService>().isAuthenticated,
        isOnboardingCompleted: getIt<IsOnboardingCompletedUseCase>().call,
      );
      unawaited(cubit.start());
      return cubit;
    },
    child: BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        switch (state.destination) {
          case SplashDestination.home:
            unawaited(context.router.replace(const HomeRoute()));
          case SplashDestination.onboarding:
            unawaited(context.router.replace(const OnboardingRoute()));
          case SplashDestination.signIn:
            unawaited(context.router.replace(const SignInRoute()));
          case null:
            break;
        }
      },
      child: BlocBuilder<SplashCubit, SplashState>(
        builder: (context, state) => Scaffold(
          body: SafeArea(
            child: state.hasError
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppText(text: tr.requestFailed, fontSize: 16.sp),
                        SizedBox(height: 16.h),
                        AppButton(
                          onTap: () => context.read<SplashCubit>().retry(),
                          child: AppText(
                            text: tr.retry,
                            fontSize: 16.sp,
                            color: appColors.background,
                          ),
                        ),
                      ],
                    ),
                  )
                : Stack(
                    children: [
                      Center(
                        child: Assets.images.png.logo.image(
                          width: 120.w,
                          height: 118.h,
                          color: appColors.primary,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            Assets.images.png.routeLogo.image(
                              width: 180.w,
                              height: 76.h,
                              color: appColors.primary,
                            ),
                            SizedBox(height: 10.h),
                            AppText(
                              text: 'Supervised by Mohamed Nabil',
                              fontSize: 16.sp,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    ),
  );
}
