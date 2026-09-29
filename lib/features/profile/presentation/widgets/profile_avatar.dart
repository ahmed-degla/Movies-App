import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/generated/assets/assets.gen.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({
    required this.imagePath,
    super.key,
    this.size,
    this.onTap,
  });

  final String imagePath;
  final double? size;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final avatarSize = size ?? context.w(118);
    final resolvedImagePath = resolveImagePath(imagePath);
    final image =
        resolvedImagePath.startsWith('https://') ||
            resolvedImagePath.startsWith('http://')
        ? Image.network(
            resolvedImagePath,
            width: avatarSize,
            height: avatarSize,
            fit: BoxFit.cover,
            errorBuilder: (_, _, _) => Image.asset(
              Assets.images.png.profileImage1.path,
              width: avatarSize,
              height: avatarSize,
              fit: BoxFit.cover,
            ),
          )
        : Image.asset(
            resolvedImagePath,
            width: avatarSize,
            height: avatarSize,
            fit: BoxFit.cover,
          );

    final avatar = ClipOval(child: image);

    if (onTap == null) {
      return avatar;
    }

    return GestureDetector(onTap: onTap, child: avatar);
  }

  static String resolveImagePath(String path) {
    final legacyAvatar = RegExp(
      r'^(?:assets/images/png/)?(?:Avatar|profile)(\d+)\.png$',
    ).firstMatch(path);
    final imageNumber = int.tryParse(legacyAvatar?.group(1) ?? '');
    if (imageNumber != null && imageNumber >= 1 && imageNumber <= 10) {
      return 'assets/images/png/profile_image_$imageNumber.png';
    }
    return path;
  }
}
