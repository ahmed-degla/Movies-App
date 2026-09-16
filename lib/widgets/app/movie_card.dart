import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({
    required this.imageUrl,
    required this.rating,
    super.key,
    this.onTap,
  });

  final String imageUrl;
  final num rating;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    child: Stack(
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(context.r(12)),
          ),
          child: AppNetWorkImage(
            imageUrl: imageUrl,
            borderRadius: BorderRadius.circular(context.r(20)),
          ),
        ),
        PositionedDirectional(
          top: 6,
          start: 8,
          child: Container(
            padding: context.edgeInsets(horizontal: 8, vertical: 6),
            decoration: BoxDecoration(
              color: appColors.background.withValues(alpha: .7),
              borderRadius: BorderRadius.circular(context.r(10)),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppText(text: rating.toString(), fontSize: context.sp(16)),
                SizedBox(width: context.w(4)),
                Icon(
                  Icons.star,
                  color: appColors.primary,
                  size: context.sp(22),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
