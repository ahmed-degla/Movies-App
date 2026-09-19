import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/resources/assets_manager.dart';

class EmptyMoviesPlaceholder extends StatelessWidget {
  const EmptyMoviesPlaceholder({super.key});

  @override
  Widget build(BuildContext context) => Center(
    child: Image.asset(
      AssetsManager.empty,
      width: context.w(124),
      height: context.h(124),
      fit: BoxFit.contain,
    ),
  );
}
