
import 'package:movies/generated/assets/assets.gen.dart';

enum HomeTaps {
  home,
  search,
  browse,
  profile,
}

extension HomeTapsExtension on HomeTaps {

  String get icon {
    switch (this) {
      case HomeTaps.home:
        return Assets.images.svg.home.path;
      case HomeTaps.search:
        return Assets.images.svg.search.path;
      case HomeTaps.browse:
        return Assets.images.svg.explore.path;

      case HomeTaps.profile:
        return Assets.images.svg.profile.path;
    }
  }

}