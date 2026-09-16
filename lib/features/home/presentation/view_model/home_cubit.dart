import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/home/domain/use_cases/get_movies_use_case.dart';

part 'home_states.dart';

@Injectable()
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this._getMoviesUseCase) : super(const HomeInit()) {
    _getMovies();
  }

  final GetMoviesUseCase _getMoviesUseCase;

  static HomeCubit of(BuildContext context) => BlocProvider.of(context);

  final movies = <MovieEntity>[];

  final randomMovies = <List<MovieEntity>>[];

  int currentCarouselIndex = 0;

  Future<void> _getMovies() async {
    emit(const HomeLoading());

    final result = await _getMoviesUseCase.call();

    switch (result) {
      case ApiSuccess<List<MovieEntity>>():
        movies
          ..clear()
          ..addAll(result.data);

        emit(const HomeLoaded());

      case ApiError<List<MovieEntity>>():
        emit(HomeFailed(message: result.message));
    }
  }

  List<MovieEntity> getRandomMovies() {
    final shuffledMovies = List<MovieEntity>.from(movies)..shuffle();
    if (shuffledMovies.length < 3) {
      return shuffledMovies;
    }

    return shuffledMovies.take(3).toList();
  }

  void changeIndex(int index) {
    _emit(const HomeTapIndexUpdated().copyWith(selectedIndex: index));
  }

  void changeCarouselIndex(int index) {
    currentCarouselIndex = index;

    _emit(const HomeCarouselIndexUpdated().copyWith(carouselIndex: index));
  }

  bool get isStateLoading => state is HomeLoading;

  void _emit(HomeStates state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
