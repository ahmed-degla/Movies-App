import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

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

    final avatar = ClipOval(
      child: Image.asset(
        imagePath,
        width: avatarSize,
        height: avatarSize,
        fit: BoxFit.cover,
      ),
    );

    if (onTap == null) {
      return avatar;
    }

    return GestureDetector(
      onTap: onTap,
      child: avatar,
    );
  }
}
