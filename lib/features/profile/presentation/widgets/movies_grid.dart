import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/features/profile/presentation/widgets/empty_movies_placeholder.dart';
import 'package:movies/features/profile/presentation/widgets/movie_poster_card.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';

class MoviePreview {
  const MoviePreview({required this.posterUrl, required this.rating});

  final String posterUrl;
  final double rating;

  factory MoviePreview.fromMovie(MovieEntity movie) => MoviePreview(
    posterUrl: movie.largeCoverImage,
    rating: movie.rating.toDouble(),
  );
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
      itemBuilder: (context, index) => MoviePosterCard(
        posterUrl: movies[index].posterUrl,
        rating: movies[index].rating,
      ),
    );
  }
}
