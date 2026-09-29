import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/general_cubit/general_cubit.dart';
import 'package:movies/core/routing/app_router.dart';
import 'package:movies/core/theme/theme_modes.dart';
import 'package:movies/generated/l10n/app_localizations.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<GeneralCubit, GeneralState>(
    builder: (context, state) => ScreenUtilPlusInit(
      designSize: const Size(430, 932),
      builder: (context, _) => MaterialApp.router(
        routerConfig: AppRouter.instance.config(),

        title: 'Movies',

        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: state.themeMode,

        locale: state.locale,

        supportedLocales: const [Locale('en'), Locale('ar')],

        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],

        debugShowCheckedModeBanner: false,

        scrollBehavior: const NoGlowScrollBehavior(),

        builder: (context, child) => GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          child: child ?? const SizedBox.shrink(),
        ),
      ),
    ),
  );
}

class NoGlowScrollBehavior extends MaterialScrollBehavior {
  const NoGlowScrollBehavior();

  @override
  Widget buildOverscrollIndicator(
    BuildContext context,
    Widget child,
    ScrollableDetails details,
  ) => child;
}
