import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/widgets/app_text.dart';

class GenreChip extends StatelessWidget {
  const GenreChip({required this.genre, super.key});

  final String genre;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.symmetric(
          horizontal: context.w(16),
          vertical: context.h(8),
        ),
        decoration: BoxDecoration(
          color: appColors.fill,
          borderRadius: BorderRadius.circular(context.r(12)),
          border: Border.all(color: Colors.white24),
        ),
        child: AppText(
          text: genre,
          fontSize: context.sp(14),
          fontWeight: FontWeight.w500,
        ),
      );
}
