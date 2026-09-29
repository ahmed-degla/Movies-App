import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/presentation/view_model/movie_details_cubit.dart';
import 'package:movies/features/movie_details/presentation/widgets/torrent_bottom_sheet.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_back_button.dart';
import 'package:movies/widgets/app_bottom_sheet.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_network_image.dart';
import 'package:movies/widgets/app_text.dart';

class MovieDetailsHeader extends StatelessWidget {
  const MovieDetailsHeader({
    required this.movie,
    required this.isWatchlist,
    super.key,
  });

  final MovieDetailsEntity movie;
  final bool isWatchlist;

  void _onWatchTap(BuildContext context) {
    unawaited(
      AppBottomSheet.show(
        context: context,
        builder: (_) => TorrentBottomSheet(movie: movie),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backdropUrl = movie.largeScreenshotImageOrDefault;

    return Stack(
      children: [
        SizedBox(
          height: context.h(520),
          width: double.infinity,
          child: AppNetWorkImage(imageUrl: backdropUrl),
        ),

        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.6),
                  Colors.transparent,
                  appColors.background.withValues(alpha: 0.8),
                  appColors.background,
                ],
                stops: const [0.0, 0.25, 0.75, 1.0],
              ),
            ),
          ),
        ),

        SafeArea(
          child: Padding(
            padding: context.edgeInsets(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const AppBackButton(),
                IconButton(
                  onPressed: () {
                    unawaited(MovieDetailsCubit.of(context).toggleWatchlist());
                  },
                  icon: Icon(
                    isWatchlist ? Icons.bookmark : Icons.bookmark_border,
                    color: isWatchlist ? appColors.primary : Colors.white,
                    size: context.sp(32),
                  ),
                ),
              ],
            ),
          ),
        ),

        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Padding(
            padding: context.edgeInsets(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () => _onWatchTap(context),
                  child: Container(
                    width: context.w(64),
                    height: context.w(64),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: appColors.primary,
                      boxShadow: [
                        BoxShadow(
                          color: appColors.primary.withValues(alpha: 0.45),
                          blurRadius: 20,
                          spreadRadius: 4,
                        ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.play_arrow_rounded,
                        color: Colors.white,
                        size: context.sp(42),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: context.h(24)),

                AppText(
                  text: movie.title,
                  fontSize: context.sp(24),
                  fontWeight: FontWeight.bold,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: context.h(6)),

                if (movie.year > 0)
                  AppText(
                    text: movie.year.toString(),
                    fontSize: context.sp(20),
                    color: appColors.primaryText.withValues(alpha: 0.5),
                    textAlign: TextAlign.center,
                    fontWeight: FontWeight.bold,
                  ),
                SizedBox(height: context.h(16)),

                AppButton(
                  onTap: () => _onWatchTap(context),
                  backgroundColor: appColors.secondary,
                  borderRadius: context.r(14),
                  width: double.infinity,
                  height: context.h(48),
                  child: AppText(
                    text: tr.watch,
                    fontSize: context.sp(18),
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: context.h(16)),

                Row(
                  children: [
                    _StatPill(
                      icon: Assets.images.svg.like.svg(
                        width: context.w(24),
                        height: context.w(24),
                        colorFilter: ColorFilter.mode(
                          appColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      value: '${movie.likeCount}',
                    ),
                    SizedBox(width: context.w(12)),
                    _StatPill(
                      icon: Assets.images.svg.time.svg(
                        width: context.w(24),
                        height: context.w(24),
                        colorFilter: ColorFilter.mode(
                          appColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      value: '${movie.runtime}',
                    ),
                    SizedBox(width: context.w(12)),
                    _StatPill(
                      icon: Assets.images.svg.star.svg(
                        width: context.w(24),
                        height: context.w(24),
                        colorFilter: ColorFilter.mode(
                          appColors.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                      value: movie.rating.toStringAsFixed(1),
                    ),
                  ],
                ),
                SizedBox(height: context.h(20)),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatPill extends StatelessWidget {
  const _StatPill({required this.icon, required this.value});

  final Widget icon;
  final String value;

  @override
  Widget build(BuildContext context) => Expanded(
    child: Container(
      padding: context.edgeInsets(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: appColors.fill,
        borderRadius: BorderRadius.circular(context.r(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          SizedBox(width: context.w(6)),
          Flexible(
            child: AppText(
              text: value,
              fontSize: context.sp(16),
              fontWeight: FontWeight.w600,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

extension on MovieDetailsEntity {
  String get largeScreenshotImageOrDefault {
    if (largeCoverImage.isNotEmpty) return largeCoverImage;
    if (mediumCoverImage.isNotEmpty) return mediumCoverImage;
    if (backgroundImageOriginal.isNotEmpty) return backgroundImageOriginal;
    if (backgroundImage.isNotEmpty) return backgroundImage;
    return '';
  }
}
