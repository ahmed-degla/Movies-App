import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/generated/assets/assets.gen.dart';

class UpdateProfileFieldIcon extends StatelessWidget {
  const UpdateProfileFieldIcon({required this.icon, super.key});

  final SvgGenImage icon;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsetsDirectional.only(start: context.w(16)),
        child: icon.svg(
          width: context.w(22),
          height: context.w(22),
        ),
      );
}
