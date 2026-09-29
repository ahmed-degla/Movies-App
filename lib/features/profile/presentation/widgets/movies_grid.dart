import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/profile/presentation/widgets/empty_movies_placeholder.dart';
import 'package:movies/features/profile/presentation/widgets/movie_poster_card.dart';

class MoviePreview {
  const MoviePreview({
    required this.movieId,
    required this.posterUrl,
    required this.rating,
  });

  factory MoviePreview.fromMovie(MovieEntity movie) => MoviePreview(
    movieId: movie.id,
    posterUrl: movie.largeCoverImage,
    rating: movie.rating.toDouble(),
  );

  final String movieId;
  final String posterUrl;
  final double rating;
}

class MoviesGrid extends StatelessWidget {
  const MoviesGrid({required this.movies, super.key});

  final List<MoviePreview> movies;

  @override
  Widget build(BuildContext context) {
    if (movies.isEmpty) {
      return const EmptyMoviesPlaceholder();
    }

    return GridView.builder(
      padding: context.edgeInsets(horizontal: 16, vertical: 8),
      itemCount: movies.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: context.w(12),
        mainAxisSpacing: context.h(12),
        childAspectRatio: 0.67,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return MoviePosterCard(
          posterUrl: movie.posterUrl,
          rating: movie.rating,
          onTap: () {
            final movieId = int.tryParse(movie.movieId);
            if (movieId != null) {
              unawaited(
                context.router.push(MovieDetailsRoute(movieId: movieId)),
              );
            }
          },
        );
      },
    );
  }
}
