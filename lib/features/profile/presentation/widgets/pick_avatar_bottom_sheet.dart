import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/profile/presentation/widgets/profile_avatar.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_bottom_sheet.dart';

class PickAvatarBottomSheet {
  const PickAvatarBottomSheet._();

  static final List<String> avatars = [
    Assets.images.png.profileImage1.path,
    Assets.images.png.profileImage2.path,
    Assets.images.png.profileImage3.path,
    Assets.images.png.profileImage4.path,
    Assets.images.png.profileImage5.path,
    Assets.images.png.profileImage6.path,
    Assets.images.png.profileImage7.path,
    Assets.images.png.profileImage8.path,
    Assets.images.png.profileImage9.path,
    Assets.images.png.profileImage10.path,
  ];

  static Future<String?> show({required String selectedAvatar}) =>
      AppBottomSheet.show<String>(
        builder: (context) =>
            _PickAvatarSheetContent(selectedAvatar: selectedAvatar),
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
                  ? appColors.primary.withValues(alpha: .6)
                  : appColors.fill,
              borderRadius: BorderRadius.circular(context.r(20)),
              border: Border.all(color: appColors.primary, width: context.w(2)),
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
