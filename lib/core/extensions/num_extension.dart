import 'package:flutter/material.dart';

import 'package:movies/core/routing/app_router.dart';

extension NumDprExtension on num {
  double get dpr {
    final context = AppRouter.instance.navigatorKey.currentContext;

    if (context == null) return toDouble();

    return this * MediaQuery.devicePixelRatioOf(context);
  }

  int get dprInt {
    final val = dpr;
    if (val.isInfinite || val.isNaN) return 0;
    return val.round();
  }
}