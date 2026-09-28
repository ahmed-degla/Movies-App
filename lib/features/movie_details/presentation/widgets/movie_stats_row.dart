import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/presentation/widgets/stat_chip.dart';
import 'package:movies/generated/assets/assets.gen.dart';

class MovieStatsRow extends StatelessWidget {
  const MovieStatsRow({required this.movie, super.key});

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    final runtimeValue = movie.runtime > 0 ? '${movie.runtime}' : 'N/A';
    final ratingValue = movie.rating > 0
        ? movie.rating.toStringAsFixed(1)
        : '0.0';

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(16)),
      child: Row(
        children: [
          Expanded(
            child: StatChip(
              icon: Assets.images.svg.heart,
              value: movie.likesCount.toString(),
            ),
          ),
          SizedBox(width: context.w(10)),
          Expanded(
            child: StatChip(
              icon: Assets.images.svg.watched,
              value: runtimeValue,
            ),
          ),
          SizedBox(width: context.w(10)),
          Expanded(
            child: StatChip(
              icon: Assets.images.svg.rate,
              value: ratingValue,
            ),
          ),
        ],
      ),
    );
  }
}
