import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class MovieCastSection extends StatelessWidget {
  const MovieCastSection({
    required this.movie,
    super.key,
  });

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) {
    if (movie.cast.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: context.edgeInsets(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: tr.cast,
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(12)),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: movie.cast.length,
            separatorBuilder: (_, _) => SizedBox(height: context.h(10)),
            itemBuilder: (context, index) {
              final castMember = movie.cast[index];
              return Container(
                padding: context.edgeInsets(all: 10),
                decoration: BoxDecoration(
                  color: appColors.fill,
                  borderRadius: BorderRadius.circular(context.r(14)),
                ),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(context.r(10)),
                      child: SizedBox(
                        width: context.w(52),
                        height: context.w(52),
                        child: castMember.urlSmallImage != null &&
                                castMember.urlSmallImage!.isNotEmpty
                            ? AppNetWorkImage(
                                imageUrl: castMember.urlSmallImage!,
                              )
                            : ColoredBox(
                                color: Colors.grey.shade800,
                                child: Icon(
                                  Icons.person,
                                  color: Colors.grey.shade400,
                                  size: context.sp(28),
                                ),
                              ),
                      ),
                    ),
                    SizedBox(width: context.w(14)),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText(
                            text: '${tr.namePrefix}${castMember.name}',
                            fontSize: context.sp(14),
                            fontWeight: FontWeight.w600,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: context.h(4)),
                          AppText(
                            text:
                                '${tr.characterPrefix}${castMember.characterName}',
                            fontSize: context.sp(13),
                            color: Colors.grey.shade400,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
