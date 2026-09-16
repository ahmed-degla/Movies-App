import 'package:auto_route/auto_route.dart';
import 'package:movies/core/routing/app_router.gr.dart';

@AutoRouter()
@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class AppRouter extends RootStackRouter {
  AppRouter._();

  static final instance = AppRouter._();

  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: SplashRoute.page, path: '/splash',initial: true,),
    AutoRoute(page: ProfileRoute.page,  path: '/profile'),
    AutoRoute(page: UpdateProfileRoute.page, path: '/update-profile'),
    AutoRoute(page: HomeRoute.page, path: '/home'),

  ];
}

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) {}
}
