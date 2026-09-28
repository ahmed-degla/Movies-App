import 'package:movies/generated/assets/assets.gen.dart';

enum Avatar {
  avatar1,
  avatar2,
  avatar3,
  avatar4,
  avatar5,
  avatar6,
  avatar7,
  avatar8,
  avatar9;

  AssetGenImage get avatar => switch (this) {
    Avatar.avatar1 => Assets.images.png.avatar1,
    Avatar.avatar2 => Assets.images.png.avatar2,
    Avatar.avatar3 => Assets.images.png.avatar3,
    Avatar.avatar4 => Assets.images.png.avatar4,
    Avatar.avatar5 => Assets.images.png.avatar5,
    Avatar.avatar6 => Assets.images.png.avatar6,
    Avatar.avatar7 => Assets.images.png.avatar7,
    Avatar.avatar8 => Assets.images.png.avatar8,
    Avatar.avatar9 => Assets.images.png.avatar9,
  };
}
