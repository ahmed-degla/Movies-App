import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/di/injection.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/core/utils/localized_error_message.dart';
import 'package:movies/features/movie_details/presentation/view_model/movie_details_cubit.dart';
import 'package:movies/features/movie_details/presentation/widgets/movie_cast_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/movie_details_header.dart';
import 'package:movies/features/movie_details/presentation/widgets/movie_genres_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/movie_screenshots_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/movie_summary_section.dart';
import 'package:movies/features/movie_details/presentation/widgets/similar_movies_section.dart';
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
      unawaited(cubit.loadMovieDetails(movieId));
      return cubit;
    },
    child: Scaffold(
      backgroundColor: appColors.background,
      body: BlocBuilder<MovieDetailsCubit, MovieDetailsState>(
        builder: (context, state) {
          if (state is MovieDetailsLoading || state is MovieDetailsInitial) {
            return const Center(child: AppProgressIndicator());
          }

          if (state is MovieDetailsError) {
            return Center(
              child: Padding(
                padding: context.edgeInsets(all: 24),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      color: appColors.secondary,
                      size: context.sp(56),
                    ),
                    SizedBox(height: context.h(16)),
                    AppText(
                      text: localizedErrorMessage(context, state.message),
                      textAlign: TextAlign.center,
                      fontSize: context.sp(16),
                    ),
                    SizedBox(height: context.h(24)),
                    AppButton(
                      width: context.w(140),
                      height: context.h(42),
                      onTap: () => unawaited(
                        MovieDetailsCubit.of(context).loadMovieDetails(movieId),
                      ),
                      child: AppText(text: tr.retry),
                    ),
                  ],
                ),
              ),
            );
          }

          if (state is MovieDetailsLoaded) {
            final movie = state.movie;
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MovieDetailsHeader(
                    movie: movie,
                    isWatchlist: state.isWatchlist,
                  ),
                  SizedBox(height: context.h(16)),
                  MovieScreenshotsSection(movie: movie),
                  SizedBox(height: context.h(16)),
                  SimilarMoviesSection(suggestions: state.suggestions),
                  SizedBox(height: context.h(16)),
                  MovieSummarySection(movie: movie),
                  SizedBox(height: context.h(16)),
                  MovieCastSection(movie: movie),
                  SizedBox(height: context.h(16)),
                  MovieGenresSection(movie: movie),
                  SizedBox(height: context.h(32)),
                ],
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    ),
  );
}
