import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:movies/core/general_cubit/general_cubit.dart';

import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({super.key, this.child});

  final Widget? child;

  @override
  Widget build(BuildContext context) {
    context.watch<GeneralCubit>();

    return InkWell(
    overlayColor: WidgetStateProperty.all(Colors.transparent),
    onTap: () => context.router.maybePop(),
    child: Padding(
      padding: EdgeInsetsDirectional.only(start: context.w(8)),
      child: RotatedBox(
        quarterTurns: AppUtils.isAr ? 2 : 0,
        child:
            child ??
            Icon(
              FontAwesomeIcons.chevronRight.data,
              color: appColors.primary,
              size: context.sp(18),
            ),
      ),
    ),
  );
  }
}
