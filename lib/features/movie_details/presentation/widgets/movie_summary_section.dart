import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/widgets/app_text.dart';

class MovieSummarySection extends StatelessWidget {
  const MovieSummarySection({
    required this.movie,
    super.key,
  });

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    final summary = movie.descriptionFull.isNotEmpty
        ? movie.descriptionFull
        : movie.descriptionIntro;

    if (summary.trim().isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: context.edgeInsets(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: tr.summary,
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(8)),
          AppText(
            text: summary,
            fontSize: context.sp(14),
            color: Colors.grey.shade300,
            height: 1.5,
          ),
        ],
      ),
    );
  }
}
