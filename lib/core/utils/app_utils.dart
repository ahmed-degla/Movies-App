import 'package:flutter/cupertino.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/general_cubit/general_cubit.dart';
import 'package:movies/core/routing/app_router.dart';
import 'package:movies/generated/l10n/app_localizations.dart';

AppLocalizations get tr => AppLocalizations.of(AppUtils.context)!;

class AppUtils {
  static BuildContext get context {
    final context = AppRouter.instance.navigatorKey.currentContext;
    if (context == null) {
      throw StateError('App router context is not available yet.');
    }
    return context;
  }

  static String get dummyImage => 'https://picsum.photos/500/500';

  static bool get isAr => getIt.get<GeneralCubit>().isArabic;
}
