import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/movie_details/domain/entity/cast_member_entity.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class CastCard extends StatelessWidget {
  const CastCard({required this.cast, super.key});

  final CastMemberEntity cast;

  @override
  Widget build(BuildContext context) => Container(
        padding: EdgeInsets.all(context.w(12)),
        decoration: BoxDecoration(
          color: appColors.fill,
          borderRadius: BorderRadius.circular(context.r(20)),
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(context.r(12)),
              child: SizedBox(
                width: context.w(64),
                height: context.h(64),
                child: AppNetWorkImage(
                  imageUrl: cast.avatarImage,
                ),
              ),
            ),
            SizedBox(width: context.w(12)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText(
                    text: 'Name : ${cast.name}',
                    fontSize: context.sp(14),
                    fontWeight: FontWeight.bold,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: context.h(4)),
                  AppText(
                    text: 'Character : ${cast.characterName}',
                    fontSize: context.sp(13),
                    color: appColors.primaryText.withValues(alpha: 0.7),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      );
}
