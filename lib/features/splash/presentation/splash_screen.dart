import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/splash/presentation/view_model/splash_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => SplashCubit(),
    child: BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state.isReady) {
          unawaited(context.router.replace(const HomeRoute()));
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: Stack(
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
  );
}
