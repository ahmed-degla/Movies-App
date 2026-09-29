import 'package:injectable/injectable.dart';
import 'package:movies/core/internet_checker/internet_checker.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/datasource/movie_datasource.dart';
import 'package:movies/features/home/data/model/movie_model.dart';
import 'package:movies/features/home/data/model/movies_param.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/home/domain/repo/movies_repo.dart';

@Injectable(as: MoviesRepo)
class MoviesRepoImpl implements MoviesRepo {
  MoviesRepoImpl(this._movieDataSource);

  final MovieDataSource _movieDataSource;

  @override
  FutureApiResult<List<MovieEntity>> getMovies(GetMoviesParams params) async {
    if (!await InternetChecker.checkConnection()) {
      return const ApiError(message: 'No internet connection');
    }

    try {
      final result = await _movieDataSource.getMovies(params);

      return switch (result) {
        ApiSuccess<List<MovieModel>>(:final data) => ApiSuccess(
          data: data.map((movie) => movie.toEntity()).toList(),
        ),
        ApiError(:final message) => ApiError(message: message),
      };
    } on Exception catch (e) {
      return ApiError(message: e.toString());
    }
  }
}
