import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/presentation/widgets/genre_chip.dart';
import 'package:movies/widgets/app_text.dart';

class GenresSection extends StatelessWidget {
  const GenresSection({required this.genres, super.key});

  final List<String> genres;

  @override
  Widget build(BuildContext context) {
    if (genres.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: tr.movieDetailsGenres,
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(12)),
          Wrap(
            spacing: context.w(10),
            runSpacing: context.h(10),
            children: genres.map((g) => GenreChip(genre: g)).toList(),
          ),
        ],
      ),
    );
  }
}
