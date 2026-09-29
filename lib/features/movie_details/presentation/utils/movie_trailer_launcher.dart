import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/widgets/app_snack_bar.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> openMovieTrailer(MovieDetailsEntity movie) async {
  if (movie.trailerCode.isEmpty) {
    AppSnackBar.show(
      message: tr.movieDetailsNoTrailer,
      type: AppSnackBarType.warning,
    );
    return;
  }

  final uri = Uri.https('www.youtube.com', '/watch', {'v': movie.trailerCode});

  try {
    final launched = await launchUrl(uri, mode: LaunchMode.externalApplication);

    if (!launched) {
      AppSnackBar.show(
        message: tr.movieDetailsTrailerOpenFailed,
        type: AppSnackBarType.error,
      );
    }
  } on Exception {
    AppSnackBar.show(
      message: tr.movieDetailsTrailerOpenFailed,
      type: AppSnackBarType.error,
    );
  }
}
