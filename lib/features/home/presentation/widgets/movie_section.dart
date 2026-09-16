import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app/movie_card.dart';
import 'package:movies/widgets/app_text.dart';

class MovieSection extends StatelessWidget {
  const MovieSection({
    required this.title,
    required this.imageUrls,
    required this.ratings,
    super.key,
    this.onSeeMore,
    this.onItemTap,
  });

  final String title;
  final List<String> imageUrls;
  final List<double> ratings;
  final VoidCallback? onSeeMore;
  final ValueChanged<int>? onItemTap;

  @override
  Widget build(BuildContext context) => Padding(
    padding: context.edgeInsets(horizontal: 16),
    child: Column(
      children: [
        Row(
          children: [
            AppText(text: title, fontSize: context.sp(20)),
            const Spacer(),
            AppText(
              text: tr.seeMore,
              fontSize: context.sp(16),
              color: appColors.primary,
              onTap: onSeeMore,
            ),
            SizedBox(width: context.w(4)),
            InkWell(
              onTap: onSeeMore,
              child: Assets.images.svg.arrow.svg(
                width: context.w(12),
                height: context.h(12),
                colorFilter: ColorFilter.mode(
                  appColors.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: context.h(12)),
        SizedBox(
          height: context.h(220),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: imageUrls.length,
            itemBuilder: (context, index) => MovieCard(
              imageUrl: imageUrls[index],
              rating: ratings[index],
              onTap: () => onItemTap?.call(index),
            ),
            separatorBuilder: (_, _) => SizedBox(width: context.w(12)),
          ),
        ),
      ],
    ),
  );
}
