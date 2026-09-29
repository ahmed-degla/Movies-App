import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/presentation/view_model/movie_details_cubit.dart';
import 'package:movies/features/movie_details/presentation/widgets/cast_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/genres_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/movie_backdrop_header.dart';
import 'package:movies/features/movie_details/presentation/widgets/movie_stats_row.dart';
import 'package:movies/features/movie_details/presentation/widgets/screenshots_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/similar_movies_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/summary_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/watch_button.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_progress_indicator.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class MovieDetailsScreen extends StatelessWidget {
  const MovieDetailsScreen({required this.movieId, super.key});

  final int movieId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) {
      final cubit = getIt<MovieDetailsCubit>();
      unawaited(cubit.fetchMovieDetails(movieId));
      return cubit;
    },
    child: Scaffold(
      backgroundColor: appColors.background,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsStates>(
        builder: (context, state) => switch (state) {
          MovieDetailsInit() ||
          MovieDetailsLoading() => const Center(child: AppProgressIndicator()),
          MovieDetailsError(:final message) => _ErrorView(
            message: message,
            onRetry: () {
              unawaited(
                MovieDetailsCubit.of(context).fetchMovieDetails(movieId),
              );
            },
          ),
          MovieDetailsLoaded(:final movie) => _LoadedView(movie: movie),
        },
      ),
    ),
  );
}

class _LoadedView extends StatelessWidget {
  const _LoadedView({required this.movie});

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
    padding: EdgeInsets.only(bottom: context.h(32)),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieBackdropHeader(movie: movie),
        SizedBox(height: context.h(16)),
        WatchButton(movie: movie),
        SizedBox(height: context.h(12)),
        MovieStatsRow(movie: movie),
        SizedBox(height: context.h(24)),
        ScreenshotsSection(screenshots: movie.screenshots),
        SizedBox(height: context.h(24)),
        SimilarMoviesSection(similarMovies: movie.similarMovies),
        SizedBox(height: context.h(24)),
        SummarySection(summary: movie.summary),
        SizedBox(height: context.h(24)),
        CastSection(cast: movie.cast),
        SizedBox(height: context.h(24)),
        GenresSection(genres: movie.genres),
      ],
    ),
  );
}

class _ErrorView extends StatelessWidget {
  const _ErrorView({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(32)),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline_rounded,
            color: appColors.secondary,
            size: context.sp(56),
          ),
          SizedBox(height: context.h(16)),
          AppText(
            text: message,
            fontSize: context.sp(16),
            textAlign: TextAlign.center,
            color: appColors.primaryText.withValues(alpha: 0.7),
          ),
          SizedBox(height: context.h(20)),
          AppButton(
            onTap: onRetry,
            width: context.w(160),
            height: context.h(46),
            child: AppText(
              text: tr.movieDetailsTryAgain,
              fontSize: context.sp(15),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    ),
  );
}
