import 'package:movies/generated/assets/assets.gen.dart';

enum HomeTaps {
  home,
  search,
  browse,
  profile,
}

extension HomeTapsExtension on HomeTaps {
  SvgGenImage get icon {
    switch (this) {
      case HomeTaps.home:
        return Assets.images.svg.home;
      case HomeTaps.search:
        return Assets.images.svg.search;
      case HomeTaps.browse:
        return Assets.images.svg.explore;
      case HomeTaps.profile:
        return Assets.images.svg.profile;
    }
  }
}
