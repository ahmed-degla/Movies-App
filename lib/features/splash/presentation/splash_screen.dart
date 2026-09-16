import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await Future.delayed(const Duration(seconds: 3)).then((_) {
      unawaited(context.router.replace(const HomeRoute()));
    });
  }

  @override
  Widget build(BuildContext context) => Scaffold(
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
                AppText(text: 'Supervised by Mohamed Nabil', fontSize: 16.sp),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
