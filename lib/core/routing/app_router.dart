import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/routing/app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter._();

  static final instance = AppRouter._();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: SplashRoute.page,
      path: '/splash',
      initial: true,
    ),
    AutoRoute(
      page: SignInRoute.page,
      path: '/signIn',
    ),
    AutoRoute(
      page: SignUpRoute.page,
      path: '/signUp',
    ),
    AutoRoute(
      page: ForgotPasswordRoute.page,
      path: '/forgotPassword',
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: ProfileRoute.page,
      path: '/profile',
      guards: [AuthGuard()],
    ),
    AutoRoute(
      page: UpdateProfileRoute.page,
      path: '/update-profile',
      guards: [AuthGuard()],
    ),
  ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(
      NavigationResolver resolver,
      StackRouter router,
      ) {
    if (getIt.get<FirebaseAuthService>().isAuthenticated) {
      resolver.next();
      return;
    }

    unawaited(router.replace(
      const SignInRoute(),
    ));
  }
}