import 'package:injectable/injectable.dart';
import 'package:movies/core/internet_checker/internet_checker.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/datasource/movie_datasource.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/home/domain/repo/movies_repo.dart';

@Injectable(as: MoviesRepo)
class MoviesRepoImpl implements MoviesRepo {
  MoviesRepoImpl(this._movieDataSource);

  final MovieDataSource _movieDataSource;

  @override
  FutureApiResult<List<MovieEntity>> getMovies() async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }
    try {
      final result = await _movieDataSource.getMovies();
      return switch (result) {
        ApiSuccess(:final data) => ApiSuccess(data: data),
        ApiError(:final message) => ApiError(message: message),
      };
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
