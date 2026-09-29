import 'package:flutter/material.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/profile/presentation/widgets/profile_tab_item.dart';
import 'package:movies/generated/assets/assets.gen.dart';

class ProfileTabs extends StatelessWidget {
  const ProfileTabs({
    required this.isHistorySelected,
    required this.onWatchlistSelected,
    required this.onHistorySelected,
    super.key,
  });

  final bool isHistorySelected;
  final VoidCallback onWatchlistSelected;
  final VoidCallback onHistorySelected;

  @override
  Widget build(BuildContext context) {
    final strings = tr;
    return Row(
      children: [
        Expanded(
          child: ProfileTabItem(
            label: strings.watchList,
            iconPath: Assets.images.svg.watchList.path,
            isSelected: !isHistorySelected,
            onTap: onWatchlistSelected,
          ),
        ),
        Expanded(
          child: ProfileTabItem(
            label: strings.history,
            iconPath: Assets.images.svg.history.path,
            isSelected: isHistorySelected,
            onTap: onHistorySelected,
          ),
        ),
      ],
    );
  }
}
