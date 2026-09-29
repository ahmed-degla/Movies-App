import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/domain/repo/movie_details_repo.dart';

@singleton
class AddToHistoryUseCase {
  AddToHistoryUseCase(this._movieDetailsRepo);

  final MovieDetailsRepo _movieDetailsRepo;

  FutureApiResult<void> call(MovieDetailsEntity movie) =>
      _movieDetailsRepo.addToHistory(movie);
}
