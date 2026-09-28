import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/movie_details/domain/entity/similar_movie_entity.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class SimilarMovieCard extends StatelessWidget {
  const SimilarMovieCard({
    required this.movie,
    super.key,
    this.onTap,
  });

  final SimilarMovieEntity movie;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) => InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(context.r(16)),
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(context.r(16)),
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: AppNetWorkImage(
                  imageUrl: movie.posterImage,
                ),
              ),
            ),
            PositionedDirectional(
              top: context.h(8),
              start: context.w(8),
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: context.w(8),
                  vertical: context.h(4),
                ),
                decoration: BoxDecoration(
                  color: appColors.background.withValues(alpha: 0.7),
                  borderRadius: BorderRadius.circular(context.r(10)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    AppText(
                      text: movie.rating.toString(),
                      fontSize: context.sp(14),
                      fontWeight: FontWeight.w500,
                    ),
                    SizedBox(width: context.w(4)),
                    Assets.images.svg.rate.svg(
                      width: context.w(14),
                      height: context.h(14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
}
