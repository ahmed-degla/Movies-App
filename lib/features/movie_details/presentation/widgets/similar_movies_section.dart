import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/widgets/app/movie_card.dart';
import 'package:movies/widgets/app_text.dart';

class SimilarMoviesSection extends StatelessWidget {
  const SimilarMoviesSection({required this.suggestions, super.key});

  final List<MovieEntity> suggestions;

  @override
  Widget build(BuildContext context) {
    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: context.edgeInsets(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: tr.similar,
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(12)),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: suggestions.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: context.w(12),
              mainAxisSpacing: context.h(12),
              childAspectRatio: 0.68,
            ),
            itemBuilder: (context, index) {
              final movie = suggestions[index];
              return MovieCard(movie: movie);
            },
          ),
        ],
      ),
    );
  }
}
