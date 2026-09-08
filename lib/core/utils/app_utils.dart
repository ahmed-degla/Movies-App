
import 'package:flutter/cupertino.dart';

import '../general_cubit/general_cubit.dart';
import '../routing/app_router.dart';

// AppLocalizations get tr => AppLocalizations.of(AppUtils.context)!;

class AppUtils {
  static BuildContext context = AppRouter.instance.navigatorKey.currentContext!;

  static String get dummyImage => 'https://picsum.photos/500/500';

  static double get keyboardheight => MediaQuery.of(context).viewInsets.bottom;

  static bool get isAr => GeneralCubit.instance.isArabic;
}
