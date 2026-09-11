import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:flutter_svg/flutter_svg.dart';

class UpdateProfileFieldIcon extends StatelessWidget {
  const UpdateProfileFieldIcon({required this.assetPath, super.key});

  final String assetPath;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsetsDirectional.only(start: context.w(16)),
    child: SvgPicture.asset(
      assetPath,
      width: context.w(22),
      height: context.w(22),
    ),
  );
}
