import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/domain/entity/torrent_entity.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_snack_bar.dart';
import 'package:movies/widgets/app_text.dart';

class TorrentBottomSheet extends StatelessWidget {
  const TorrentBottomSheet({
    required this.movie,
    super.key,
  });

  final MovieDetailsEntity movie;

  @override
  Widget build(BuildContext context) => Padding(
        padding: context.edgeInsets(all: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: context.w(40),
                height: context.h(4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade700,
                  borderRadius: BorderRadius.circular(context.r(2)),
                ),
              ),
            ),
            SizedBox(height: context.h(16)),
            AppText(
              text: tr.availableDownloads,
              fontSize: context.sp(18),
              fontWeight: FontWeight.bold,
            ),
            SizedBox(height: context.h(8)),
            AppText(
              text: movie.title,
              fontSize: context.sp(14),
              color: Colors.grey.shade400,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: context.h(16)),
            if (movie.torrents.isEmpty)
              Padding(
                padding: context.edgeInsets(vertical: 24),
                child: Center(
                  child: AppText(
                    text: tr.noTorrentDownloads,
                    fontSize: context.sp(14),
                    color: Colors.grey,
                  ),
                ),
              )
            else
              Flexible(
                child: ListView.separated(
                  shrinkWrap: true,
                  itemCount: movie.torrents.length,
                  separatorBuilder: (_, _) => SizedBox(height: context.h(12)),
                  itemBuilder: (context, index) {
                    final torrent = movie.torrents[index];
                    return _TorrentItem(
                      torrent: torrent,
                      movieTitle: movie.title,
                    );
                  },
                ),
              ),
            SizedBox(height: context.h(16)),
          ],
        ),
      );
}

class _TorrentItem extends StatelessWidget {
  const _TorrentItem({
    required this.torrent,
    required this.movieTitle,
  });

  final TorrentEntity torrent;
  final String movieTitle;

  @override
  Widget build(BuildContext context) {
    final magnetUrl = torrent.createMagnetUrl(movieTitle: movieTitle);

    return Container(
      padding: context.edgeInsets(all: 12),
      decoration: BoxDecoration(
        color: appColors.fill,
        borderRadius: BorderRadius.circular(context.r(12)),
      ),
      child: Row(
        children: [
          Container(
            padding: context.edgeInsets(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: appColors.primary.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(context.r(8)),
              border: Border.all(
                color: appColors.primary.withValues(alpha: 0.4),
              ),
            ),
            child: AppText(
              text: torrent.quality.toUpperCase(),
              fontSize: context.sp(14),
              fontWeight: FontWeight.bold,
              color: appColors.primary,
            ),
          ),
          SizedBox(width: context.w(12)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppText(
                  text: '${torrent.type.toUpperCase()} • ${torrent.size}',
                  fontSize: context.sp(14),
                  fontWeight: FontWeight.w600,
                ),
                SizedBox(height: context.h(4)),
                Row(
                  children: [
                    Icon(
                      Icons.arrow_upward,
                      size: context.sp(12),
                      color: Colors.green,
                    ),
                    AppText(
                      text: ' ${torrent.seeds} ${tr.seeds}',
                      fontSize: context.sp(12),
                      color: Colors.grey.shade400,
                    ),
                    SizedBox(width: context.w(10)),
                    Icon(
                      Icons.arrow_downward,
                      size: context.sp(12),
                      color: Colors.redAccent,
                    ),
                    AppText(
                      text: ' ${torrent.peers} ${tr.peers}',
                      fontSize: context.sp(12),
                      color: Colors.grey.shade400,
                    ),
                  ],
                ),
              ],
            ),
          ),
          AppButton(
            width: context.w(80),
            height: context.h(36),
            borderRadius: context.r(8),
            backgroundColor: appColors.primary,
            onTap: () {
              unawaited(Clipboard.setData(ClipboardData(text: magnetUrl)));
              AppSnackBar.show(
                message: tr.magnetCopied,
                type: AppSnackBarType.success,
              );
              Navigator.of(context).pop();
            },
            child: AppText(
              text: tr.copy,
              fontSize: context.sp(12),
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
