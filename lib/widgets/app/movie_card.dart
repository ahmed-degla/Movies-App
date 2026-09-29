import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class MovieCard extends StatelessWidget {
  const MovieCard({required this.movie, super.key});

  final MovieEntity movie;

  void _openMovieDetails(BuildContext context) {
    final movieId = int.tryParse(movie.id);
    if (movieId != null) {
      unawaited(context.router.push(MovieDetailsRoute(movieId: movieId)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final imageUrl = movie.largeCoverImage.isNotEmpty
        ? movie.largeCoverImage
        : movie.mediumCoverImage;

    return InkWell(
      onTap: () => _openMovieDetails(context),
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
                  AppText(
                    text: movie.rating.toString(),
                    fontSize: context.sp(16),
                  ),
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
}
