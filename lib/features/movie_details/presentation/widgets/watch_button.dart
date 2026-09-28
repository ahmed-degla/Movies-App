import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_snack_bar.dart';
import 'package:movies/widgets/app_text.dart';

class WatchButton extends StatelessWidget {
  const WatchButton({required this.movie, super.key});

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) => Padding(
        padding: EdgeInsets.symmetric(horizontal: context.w(16)),
        child: SizedBox(
          width: double.infinity,
          child: AppButton(
            onTap: () {
              AppSnackBar.show(
                message: 'Starting ${movie.title}...',
              );
            },
            backgroundColor: appColors.secondary,
            height: context.h(52),
            width: double.infinity,
            borderRadius: context.r(16),
            child: AppText(
              text: 'Watch',
              fontSize: context.sp(18),
              fontWeight: FontWeight.bold,
              color: appColors.primaryText,
            ),
          ),
        ),
      );
}
