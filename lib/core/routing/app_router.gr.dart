// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:auto_route/auto_route.dart' as _i9;
import 'package:flutter/material.dart' as _i10;
import 'package:movies/features/auth/forgot_password/presentation/forgot_password_screen.dart'
    as _i1;
import 'package:movies/features/auth/sign_in/presentation/sign_in_screen.dart'
    as _i5;
import 'package:movies/features/auth/sign_up/presentation/sign_up_screen.dart'
    as _i6;
import 'package:movies/features/home/presentation/home_screen.dart' as _i2;
import 'package:movies/features/movie_details/presentation/screens/movie_details_screen.dart'
    as _i3;
import 'package:movies/features/onboarding/presentation/onboarding_screen.dart'
    as _i4;
import 'package:movies/features/splash/presentation/splash_screen.dart' as _i7;
import 'package:movies/features/update_profile/presentation/screens/update_profile_screen.dart'
    as _i8;

/// generated route for
/// [_i1.ForgotPasswordScreen]
class ForgotPasswordRoute extends _i9.PageRouteInfo<void> {
  const ForgotPasswordRoute({List<_i9.PageRouteInfo>? children})
    : super(ForgotPasswordRoute.name, initialChildren: children);

  static const String name = 'ForgotPasswordRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i1.ForgotPasswordScreen();
    },
  );
}

/// generated route for
/// [_i2.HomeScreen]
class HomeRoute extends _i9.PageRouteInfo<void> {
  const HomeRoute({List<_i9.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i2.HomeScreen();
    },
  );
}

/// generated route for
/// [_i3.MovieDetailsScreen]
class MovieDetailsRoute extends _i9.PageRouteInfo<MovieDetailsRouteArgs> {
  MovieDetailsRoute({
    required int movieId,
    _i10.Key? key,
    List<_i9.PageRouteInfo>? children,
  }) : super(
         MovieDetailsRoute.name,
         args: MovieDetailsRouteArgs(movieId: movieId, key: key),
         initialChildren: children,
       );

  static const String name = 'MovieDetailsRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<MovieDetailsRouteArgs>();
      return _i3.MovieDetailsScreen(movieId: args.movieId, key: args.key);
    },
  );
}

class MovieDetailsRouteArgs {
  const MovieDetailsRouteArgs({required this.movieId, this.key});

  final int movieId;

  final _i10.Key? key;

  @override
  String toString() {
    return 'MovieDetailsRouteArgs{movieId: $movieId, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MovieDetailsRouteArgs) return false;
    return movieId == other.movieId && key == other.key;
  }

  @override
  int get hashCode => movieId.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i4.OnboardingScreen]
class OnboardingRoute extends _i9.PageRouteInfo<void> {
  const OnboardingRoute({List<_i9.PageRouteInfo>? children})
    : super(OnboardingRoute.name, initialChildren: children);

  static const String name = 'OnboardingRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i4.OnboardingScreen();
    },
  );
}

/// generated route for
/// [_i5.SignInScreen]
class SignInRoute extends _i9.PageRouteInfo<void> {
  const SignInRoute({List<_i9.PageRouteInfo>? children})
    : super(SignInRoute.name, initialChildren: children);

  static const String name = 'SignInRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i5.SignInScreen();
    },
  );
}

/// generated route for
/// [_i6.SignUpScreen]
class SignUpRoute extends _i9.PageRouteInfo<void> {
  const SignUpRoute({List<_i9.PageRouteInfo>? children})
    : super(SignUpRoute.name, initialChildren: children);

  static const String name = 'SignUpRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i6.SignUpScreen();
    },
  );
}

/// generated route for
/// [_i7.SplashScreen]
class SplashRoute extends _i9.PageRouteInfo<void> {
  const SplashRoute({List<_i9.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i7.SplashScreen();
    },
  );
}

/// generated route for
/// [_i8.UpdateProfileScreen]
class UpdateProfileRoute extends _i9.PageRouteInfo<void> {
  const UpdateProfileRoute({List<_i9.PageRouteInfo>? children})
    : super(UpdateProfileRoute.name, initialChildren: children);

  static const String name = 'UpdateProfileRoute';

  static _i9.PageInfo page = _i9.PageInfo(
    name,
    builder: (data) {
      return const _i8.UpdateProfileScreen();
    },
  );
}
