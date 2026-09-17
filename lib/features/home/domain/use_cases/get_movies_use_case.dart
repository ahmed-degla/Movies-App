import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movies_param.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/home/domain/repo/movies_repo.dart';

@singleton
class GetMoviesUseCase {
  GetMoviesUseCase(this._moviesRepo);

  final MoviesRepo _moviesRepo;

  FutureApiResult<List<MovieEntity>> call(GetMoviesParams params) =>
      _moviesRepo.getMovies(params);
}
