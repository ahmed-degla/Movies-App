import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/cast_member_entity.dart';
import 'package:movies/features/movie_details/presentation/widgets/cast_card.dart';
import 'package:movies/widgets/app_text.dart';

class CastSection extends StatelessWidget {
  const CastSection({required this.cast, super.key});

  final List<CastMemberEntity> cast;

  @override
  Widget build(BuildContext context) {
    if (cast.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.w(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppText(
            text: tr.movieDetailsCast,
            fontSize: context.sp(18),
            fontWeight: FontWeight.bold,
          ),
          SizedBox(height: context.h(12)),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: cast.length,
            separatorBuilder: (_, _) => SizedBox(height: context.h(12)),
            itemBuilder: (context, index) => CastCard(cast: cast[index]),
          ),
        ],
      ),
    );
  }
}
