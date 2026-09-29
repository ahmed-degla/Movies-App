import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/movie_details/domain/repo/movie_details_repo.dart';

@singleton
class GetMovieSuggestionsUseCase {
  const GetMovieSuggestionsUseCase(this._movieDetailsRepo);

  final MovieDetailsRepo _movieDetailsRepo;

  FutureApiResult<List<MovieEntity>> call(int movieId) =>
      _movieDetailsRepo.getMovieSuggestions(movieId);
}
