import 'package:flutter/material.dart';

import 'package:movies/core/routing/app_router.dart';

AppColors get colors =>
    Theme.of(
      AppRouter.instance.navigatorKey.currentContext!,
    ).extension<AppColors>()!;

class AppColors extends ThemeExtension<AppColors> {
  const AppColors({
    required this.primary,
    required this.secondary,
    required this.background,
    required this.fill,
    required this.primaryText,
  });

  final Color primary;
  final Color secondary;
  final Color background;
  final Color fill;
  final Color primaryText;

  @override
  AppColors copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? fill,
    Color? primaryText,
  }) => AppColors(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      fill: fill ?? this.fill,
      primaryText: primaryText ?? this.primaryText,
    );

  @override
  AppColors lerp(
      covariant ThemeExtension<AppColors>? other,
      double t,
      ) {
    if (other is! AppColors) {
      return this;
    }

    return AppColors(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      fill: Color.lerp(fill, other.fill, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
    );
  }
}