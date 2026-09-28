import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/features/movie_details/domain/entity/similar_movie_entity.dart';
import 'package:movies/features/movie_details/presentation/widgets/similar_movie_card.dart';
import 'package:movies/widgets/app_text.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({required this.similarMovies, super.key});

  final List<SimilarMovieEntity> similarMovies;

  @override
  Widget build(BuildContext context) {
    if (similarMovies.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: 'Similar',
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(12)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: similarMovies.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: context.w(12),
              mainAxisSpacing: context.h(12),
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              final movie = similarMovies[index];
              return SimilarMovieCard(
                movie: movie,
                onTap: () {
                  unawaited(
                    context.router.push(MovieDetailsRoute(movieId: movie.id)),
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
