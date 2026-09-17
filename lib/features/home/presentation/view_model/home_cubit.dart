import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movies_param.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/home/domain/use_cases/get_movies_use_case.dart';

part 'home_states.dart';

@Injectable()
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this._getMoviesUseCase) : super(const HomeInit()) {
    unawaited(init());
  }

  final GetMoviesUseCase _getMoviesUseCase;

  static HomeCubit of(BuildContext context) => context.read<HomeCubit>();

  // ---------------------------------------------------------------------------
  // Controllers
  // ---------------------------------------------------------------------------

  final TextEditingController searchController = TextEditingController();

  Timer? _searchDebounce;

  // ---------------------------------------------------------------------------
  // Movies
  // ---------------------------------------------------------------------------

  final List<MovieEntity> movies = [];
  List<MovieEntity> filteredMovies = [];
  List<MovieEntity> searchResults = [];

  // ---------------------------------------------------------------------------
  // Home state
  // ---------------------------------------------------------------------------

  int selectedTapIndex = 0;

  int currentCarouselIndex = 0;

  String? selectedGenre;

  // ---------------------------------------------------------------------------
  // Genres
  // ---------------------------------------------------------------------------

  List<String> get genres =>
      movies.expand((movie) => movie.genres).toSet().toList();

  // ---------------------------------------------------------------------------
  // API params
  // ---------------------------------------------------------------------------

  GetMoviesParams _params = const GetMoviesParams(page: 1, limit: 20);

  // ---------------------------------------------------------------------------
  // Getters
  // ---------------------------------------------------------------------------

  bool get isStateLoading => state is HomeLoading;

  // ---------------------------------------------------------------------------
  // Init
  // ---------------------------------------------------------------------------

  Future<void> init() async {
    await getMovies();
  }

  // ---------------------------------------------------------------------------
  // Get Movies
  // ---------------------------------------------------------------------------

  Future<void> getMovies({GetMoviesParams? params}) async {
    _params = params ?? _params;

    emit(
      HomeLoading(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );

    final result = await _getMoviesUseCase.call(_params);

    switch (result) {
      case ApiSuccess<List<MovieEntity>>():
        movies
          ..clear()
          ..addAll(result.data);

        emit(
          HomeLoaded(
            selectedTapIndex: selectedTapIndex,
            carouselIndex: currentCarouselIndex,
            selectedGenre: selectedGenre,
          ),
        );

      case ApiError<List<MovieEntity>>():
        emit(
          HomeFailed(
            message: result.message,
            selectedTapIndex: selectedTapIndex,
            carouselIndex: currentCarouselIndex,
            selectedGenre: selectedGenre,
          ),
        );
    }
  }

  // ---------------------------------------------------------------------------
  // Search
  // ---------------------------------------------------------------------------

  void onSearchChanged(String? value) {
    _searchDebounce?.cancel();

    final query = value?.trim() ?? '';

    if (query.isEmpty) {
      searchResults.clear();

      _params = const GetMoviesParams(
        page: 1,
        limit: 20,
      );

      _emit(
        HomeLoaded(
          selectedTapIndex: selectedTapIndex,
          carouselIndex: currentCarouselIndex,
          selectedGenre: selectedGenre,
        ),
      );

      return;
    }

    _searchDebounce = Timer(
      const Duration(milliseconds: 1500),
          () async {
        _params = _params.copyWith(
          page: 1,
          queryTerm: query,
        );

        _emit(
          HomeLoading(
            selectedTapIndex: selectedTapIndex,
            carouselIndex: currentCarouselIndex,
            selectedGenre: selectedGenre,
          ),
        );

        final result = await _getMoviesUseCase.call(_params);

        switch (result) {
          case ApiSuccess<List<MovieEntity>>():
            searchResults = result.data;

            _emit(
              HomeLoaded(
                selectedTapIndex: selectedTapIndex,
                carouselIndex: currentCarouselIndex,
                selectedGenre: selectedGenre,
              ),
            );

          case ApiError<List<MovieEntity>>():
            searchResults = [];

            _emit(
              HomeFailed(
                message: result.message,
                selectedTapIndex: selectedTapIndex,
                carouselIndex: currentCarouselIndex,
                selectedGenre: selectedGenre,
              ),
            );
        }
      },
    );
  }  // ---------------------------------------------------------------------------
  // Genre
  // ---------------------------------------------------------------------------

  Future<void> onGenreSelected(String genre) async {
    if (selectedGenre == genre) return;
    _emit(
      HomeLoading(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );
    selectedGenre = genre;
    final result = await _getMoviesUseCase.call(_params.copyWith(genre: genre));
    switch (result) {
      case ApiSuccess<List<MovieEntity>>():
        filteredMovies = result.data;
        break;
      case ApiError<List<MovieEntity>>():
        filteredMovies = [];
        break;
    }

    _emit(
      HomeGenreSelected(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Minimum Rating
  // ---------------------------------------------------------------------------

  void setMinimumRating(int rating) {
    _params = _params.copyWith(page: 1, minimumRating: rating);

    unawaited(getMovies(params: _params));
  }

  // ---------------------------------------------------------------------------
  // Sorting
  // ---------------------------------------------------------------------------

  void setSorting({required String sortBy, String? orderBy}) {
    _params = _params.copyWith(page: 1, sortBy: sortBy, orderBy: orderBy);

    unawaited(getMovies(params: _params));
  }

  // ---------------------------------------------------------------------------
  // Reset filters
  // ---------------------------------------------------------------------------

  void resetFilters() {
    _searchDebounce?.cancel();

    searchController.clear();
    searchResults.clear();

    _params = const GetMoviesParams(
      page: 1,
      limit: 20,
    );

    selectedGenre = null;
    filteredMovies.clear();


  }

  // ---------------------------------------------------------------------------
  // Random Movies
  // ---------------------------------------------------------------------------

  List<MovieEntity> getRandomMovies() {
    final shuffledMovies = List<MovieEntity>.from(movies)..shuffle();

    if (shuffledMovies.length < 3) {
      return shuffledMovies;
    }

    return shuffledMovies.take(3).toList();
  }

  // ---------------------------------------------------------------------------
  // Navigation
  // ---------------------------------------------------------------------------

  void changeNavIndex(int index) {
    selectedTapIndex = index;
    resetFilters();

    _emit(
      HomeTapIndexUpdated(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Carousel
  // ---------------------------------------------------------------------------

  void changeCarouselIndex(int index) {
    currentCarouselIndex = index;

    _emit(
      HomeCarouselIndexUpdated(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // Dispose
  // ---------------------------------------------------------------------------

  @override
  Future<void> close() {
    _searchDebounce?.cancel();
    searchController.dispose();

    return super.close();
  }

  // ---------------------------------------------------------------------------
  // Emit
  // ---------------------------------------------------------------------------

  void _emit(HomeStates state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
