import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/presentation/utils/movie_trailer_launcher.dart';
import 'package:movies/features/movie_details/presentation/view_model/movie_details_cubit.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class MovieBackdropHeader extends StatelessWidget {
  const MovieBackdropHeader({required this.movie, super.key});

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    final backdropUrl = movie.backdropImage.isNotEmpty
        ? movie.backdropImage
        : movie.posterImage;

    return Column(
      children: [
        SizedBox(
          height: context.h(480),
          width: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              AppNetWorkImage(
                imageUrl: backdropUrl,
                alignment: Alignment.topCenter,
              ),
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      appColors.background.withValues(alpha: 0.4),
                      Colors.transparent,
                      appColors.background.withValues(alpha: 0.8),
                      appColors.background,
                    ],
                    stops: const [0.0, 0.35, 0.8, 1.0],
                  ),
                ),
              ),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.w(16),
                    vertical: context.h(8),
                  ),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            unawaited(context.router.maybePop());
                          },
                          child: Container(
                            width: context.w(44),
                            height: context.w(44),
                            decoration: BoxDecoration(
                              color: appColors.background.withValues(
                                alpha: 0.5,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.arrow_back_ios_new_rounded,
                              color: appColors.primaryText,
                              size: context.sp(20),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            unawaited(
                              MovieDetailsCubit.of(context).toggleBookmark(),
                            );
                          },
                          child: Container(
                            width: context.w(44),
                            height: context.w(44),
                            decoration: BoxDecoration(
                              color: appColors.background.withValues(
                                alpha: 0.5,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              movie.isBookmarked
                                  ? Icons.bookmark_rounded
                                  : Icons.bookmark_outline_rounded,
                              color: movie.isBookmarked
                                  ? appColors.primary
                                  : appColors.primaryText,
                              size: context.sp(24),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () {
                    unawaited(openMovieTrailer(movie));
                  },
                  child: Container(
                    width: context.w(80),
                    height: context.w(80),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColors.primaryText.withValues(alpha: 0.25),
                    ),
                    padding: EdgeInsets.all(context.w(8)),
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: appColors.primary,
                      ),
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: appColors.primaryText,
                        size: context.sp(42),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.w(20)),
          child: Column(
            children: [
              AppText(
                text: movie.title,
                fontSize: context.sp(22),
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: context.h(6)),
              AppText(
                text: movie.releaseYear.toString(),
                fontSize: context.sp(14),
                color: appColors.primaryText.withValues(alpha: 0.6),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
