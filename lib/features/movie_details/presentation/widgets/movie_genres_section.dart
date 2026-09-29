import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/widgets/app_text.dart';

class MovieGenresSection extends StatelessWidget {
  const MovieGenresSection({
    required this.movie,
    super.key,
  });

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    if (movie.genres.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: context.edgeInsets(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: tr.genres,
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(12)),
          Wrap(
            spacing: context.w(10),
            runSpacing: context.h(10),
            children: movie.genres
                .map(
                  (genre) => Container(
                    padding: context.edgeInsets(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: appColors.fill,
                      borderRadius: BorderRadius.circular(context.r(12)),
                    ),
                    child: AppText(
                      text: genre,
                      fontSize: context.sp(14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
