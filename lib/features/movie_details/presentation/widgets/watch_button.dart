import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/presentation/utils/movie_trailer_launcher.dart';
import 'package:movies/features/movie_details/presentation/view_model/movie_details_cubit.dart';
import 'package:movies/widgets/app_button.dart';
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
          unawaited(_watch(context));
        },
        backgroundColor: appColors.secondary,
        height: context.h(52),
        width: double.infinity,
        borderRadius: context.r(16),
        child: AppText(
          text: tr.movieDetailsWatch,
          fontSize: context.sp(18),
          fontWeight: FontWeight.bold,
          color: appColors.primaryText,
        ),
      ),
    ),
  );

  Future<void> _watch(BuildContext context) async {
    await MovieDetailsCubit.of(context).addToHistory();
    await openMovieTrailer(movie);
  }
}
