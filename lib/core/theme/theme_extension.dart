import 'package:flutter/material.dart';

import 'package:movies/core/routing/app_router.dart';

AppThemeExtension get appColors =>
    Theme.of(
      AppRouter.instance.navigatorKey.currentContext!,
    ).extension<AppThemeExtension>()!;

AppThemeExtension get colors => appColors;

typedef AppColors = AppThemeExtension;

class AppThemeExtension extends ThemeExtension<AppThemeExtension> {
  const AppThemeExtension({
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
  AppThemeExtension copyWith({
    Color? primary,
    Color? secondary,
    Color? background,
    Color? fill,
    Color? primaryText,
  }) => AppThemeExtension(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      background: background ?? this.background,
      fill: fill ?? this.fill,
      primaryText: primaryText ?? this.primaryText,
    );

  @override
  AppThemeExtension lerp(
      covariant ThemeExtension<AppThemeExtension>? other,
      double t,
      ) {
    if (other is! AppThemeExtension) {
      return this;
    }

    return AppThemeExtension(
      primary: Color.lerp(primary, other.primary, t)!,
      secondary: Color.lerp(secondary, other.secondary, t)!,
      background: Color.lerp(background, other.background, t)!,
      fill: Color.lerp(fill, other.fill, t)!,
      primaryText: Color.lerp(primaryText, other.primaryText, t)!,
    );
  }
}