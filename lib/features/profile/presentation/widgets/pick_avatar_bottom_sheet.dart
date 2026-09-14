import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/resources/assets_manager.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:movies/widgets/app_bottom_sheet.dart';

class PickAvatarBottomSheet {
  const PickAvatarBottomSheet._();

  static const List<String> avatars = [
    AssetsManager.profile1,
    AssetsManager.profile2,
    AssetsManager.profile3,
    AssetsManager.profile4,
    AssetsManager.profile5,
    AssetsManager.profile6,
    AssetsManager.profile7,
    AssetsManager.profile8,
    AssetsManager.profile9,
    AssetsManager.profile10,
  ];

  static Future<String?> show({required String selectedAvatar}) =>
      AppBottomSheet.show<String>(
        builder: (context) => _PickAvatarSheetContent(
          selectedAvatar: selectedAvatar,
        ),
      );
}

class _PickAvatarSheetContent extends StatelessWidget {
  const _PickAvatarSheetContent({required this.selectedAvatar});

  final String selectedAvatar;

  @override
  Widget build(BuildContext context) => Padding(
    padding: context.edgeInsets(horizontal: 16, vertical: 24),
    child: GridView.builder(
      shrinkWrap: true,
      itemCount: PickAvatarBottomSheet.avatars.length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: context.w(16),
        mainAxisSpacing: context.h(16),
      ),
      itemBuilder: (context, index) {
        final avatar = PickAvatarBottomSheet.avatars[index];
        final isSelected = avatar == selectedAvatar;

        return GestureDetector(
          onTap: () => Navigator.of(context).pop(avatar),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: isSelected
                  ? colors.primary.withValues(alpha: .6)
                  : colors.fill,
              borderRadius: BorderRadius.circular(context.r(20)),
              border: Border.all(
                color: colors.primary,
                width: context.w(2),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.all(context.w(8)),
              child: ProfileAvatar(imagePath: avatar),
            ),
          ),
        );
      },
    ),
  );
}
