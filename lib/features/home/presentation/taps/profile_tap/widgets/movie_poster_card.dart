import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class MoviePosterCard extends StatelessWidget {
  const MoviePosterCard({
    required this.posterUrl,
    required this.rating,
    super.key,
    this.onTap,
  });

  final String posterUrl;
  final double rating;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(context.r(16)),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(context.r(16)),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppNetWorkImage(
            imageUrl: posterUrl,
            width: double.infinity,
            height: double.infinity,
            borderRadius: BorderRadius.circular(context.r(16)),
          ),
          Positioned(
            top: context.h(8),
            left: context.w(8),
            child: Container(
              padding: context.edgeInsets(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: appColors.background.withValues(alpha: .8),
                borderRadius: BorderRadius.circular(context.r(8)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AppText(
                    text: rating.toStringAsFixed(1),
                    fontSize: context.sp(12),
                  ),
                  SizedBox(width: context.w(4)),
                  Icon(
                    Icons.star,
                    color: appColors.primary,
                    size: context.sp(14),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
