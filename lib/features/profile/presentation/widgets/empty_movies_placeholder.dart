import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/generated/assets/assets.gen.dart';

class EmptyMoviesPlaceholder extends StatelessWidget {
  const EmptyMoviesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => Center(
        child: Assets.images.png.empty.image(
          width: context.w(124),
          height: context.h(124),
          fit: BoxFit.contain,
        ),
      );
}
