import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../core/theme/theme_extension.dart';
import '../core/utils/app_utils.dart';

class AppBackButton extends StatelessWidget {
  const AppBackButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) => RotatedBox(
    quarterTurns: AppUtils.isAr ? 0 : 2,
    child: Icon(
      FontAwesomeIcons.chevronRight.data,
      color: colors.primary,
      size: context.sp(18),
    ),
  );
}
