import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class MovieScreenshotsSection extends StatelessWidget {
  const MovieScreenshotsSection({
    required this.movie,
    super.key,
  });

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    if (movie.screenshots.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: context.edgeInsets(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: tr.screenShots,
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(12)),
          ...movie.screenshots.map(
            (imageUrl) => Padding(
              padding: context.edgeInsets(bottom: 12),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(context.r(16)),
                child: SizedBox(
                  width: double.infinity,
                  height: context.h(190),
                  child: AppNetWorkImage(
                    imageUrl: imageUrl,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
