import 'package:movies/generated/assets/assets.gen.dart';

enum Avatar {
  profileImage1,
  profileImage2,
  profileImage3,
  profileImage4,
  profileImage5,
  profileImage6,
  profileImage7,
  profileImage8,
  profileImage9,
  profileImage10;

  AssetGenImage get avatar => switch (this) {
    Avatar.profileImage1 => Assets.images.png.profileImage1,
    Avatar.profileImage2 => Assets.images.png.profileImage2,
    Avatar.profileImage3 => Assets.images.png.profileImage3,
    Avatar.profileImage4 => Assets.images.png.profileImage4,
    Avatar.profileImage5 => Assets.images.png.profileImage5,
    Avatar.profileImage6 => Assets.images.png.profileImage6,
    Avatar.profileImage7 => Assets.images.png.profileImage7,
    Avatar.profileImage8 => Assets.images.png.profileImage8,
    Avatar.profileImage9 => Assets.images.png.profileImage9,
    Avatar.profileImage10 => Assets.images.png.profileImage10,
  };

  static String resolveImagePath(String path) {
    final legacyAvatar = RegExp(
      r'^(?:assets/images/png/)?(?:Avatar|profile)(\d+)\.png$',
    ).firstMatch(path);
    final imageNumber = int.tryParse(legacyAvatar?.group(1) ?? '');
    if (imageNumber != null && imageNumber >= 1 && imageNumber <= 10) {
      return values[imageNumber - 1].avatar.path;
    }
    return path;
  }

  static String? resolveKnownImagePath(String path) {
    final normalizedPath = resolveImagePath(path);
    for (final avatar in values) {
      if (avatar.avatar.path == normalizedPath) return normalizedPath;
    }
    return null;
  }
}
