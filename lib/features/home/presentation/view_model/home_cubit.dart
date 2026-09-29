import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/data/model/movies_param.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/home/domain/entity/movies_page_entity.dart';
import 'package:movies/features/home/domain/use_cases/get_movies_use_case.dart';

part 'home_states.dart';

@Injectable()
class HomeCubit extends Cubit<HomeStates> {
  HomeCubit(this._getMoviesUseCase, this._firebaseAuthService)
    : super(const HomeInit()) {
    unawaited(init());
  }

  final GetMoviesUseCase _getMoviesUseCase;
  final FirebaseAuthService _firebaseAuthService;

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
  final Map<String, List<MovieEntity>> _homeGenreSections = {};
  List<MovieEntity> filteredMovies = [];
  List<MovieEntity> searchResults = [];
  int movieCount = 0;
  int moviesPageSize = 20;
  int currentMoviesPage = 1;
  int searchMovieCount = 0;
  int searchPageSize = 20;
  int currentSearchPage = 1;
  int exploreMovieCount = 0;
  int explorePageSize = 20;
  int currentExplorePage = 1;

  // ---------------------------------------------------------------------------
  // Home state
  // ---------------------------------------------------------------------------

  int selectedTapIndex = 0;
  int selectedProfileTabIndex = 0;

  int currentCarouselIndex = 0;

  String? selectedGenre;

  // ---------------------------------------------------------------------------
  // Genres
  // ---------------------------------------------------------------------------

  List<String> get genres =>
      movies.expand((movie) => movie.genres).toSet().toList();

  List<MovieEntity> moviesForGenre(String genre) =>
      _homeGenreSections.putIfAbsent(genre, () {
        final candidates =
            movies.where((movie) => movie.genres.contains(genre)).toList()
              ..shuffle();
        return candidates.take(4).toList();
      });

  void _refreshHomeGenreSections() {
    final previousSections = Map<String, List<MovieEntity>>.of(
      _homeGenreSections,
    );
    _homeGenreSections.clear();

    for (final genre in genres) {
      final candidates =
          movies.where((movie) => movie.genres.contains(genre)).toList()
            ..shuffle();
      final previousIds = previousSections[genre]
          ?.map((movie) => movie.id)
          .toSet();
      final nextIds = candidates.take(4).map((movie) => movie.id).toSet();

      if (candidates.length > 4 &&
          previousIds != null &&
          previousIds.length == nextIds.length &&
          previousIds.containsAll(nextIds)) {
        candidates.add(candidates.removeAt(0));
      }

      _homeGenreSections[genre] = candidates.take(4).toList();
    }
  }

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
      case ApiSuccess<MoviesPageEntity>():
        movies
          ..clear()
          ..addAll(result.data.movies);
        _homeGenreSections.clear();
        movieCount = result.data.totalCount;
        moviesPageSize = result.data.limit;
        currentMoviesPage = result.data.pageNumber;
        if (currentCarouselIndex >= movies.length) {
          currentCarouselIndex = 0;
        }

        emit(
          HomeLoaded(
            selectedTapIndex: selectedTapIndex,
            carouselIndex: currentCarouselIndex,
            selectedGenre: selectedGenre,
          ),
        );

      case ApiError<MoviesPageEntity>():
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
      searchMovieCount = 0;
      currentSearchPage = 1;

      _params = const GetMoviesParams(page: 1, limit: 20);

      _emit(
        HomeLoaded(
          selectedTapIndex: selectedTapIndex,
          carouselIndex: currentCarouselIndex,
          selectedGenre: selectedGenre,
        ),
      );

      return;
    }

    searchResults = [];
    searchMovieCount = 0;
    currentSearchPage = 1;

    _searchDebounce = Timer(const Duration(milliseconds: 1500), () async {
      _emit(
        HomeLoading(
          selectedTapIndex: selectedTapIndex,
          carouselIndex: currentCarouselIndex,
          selectedGenre: selectedGenre,
        ),
      );

      final result = await _getMoviesUseCase.call(
        GetMoviesParams(page: 1, limit: 20, queryTerm: query),
      );

      switch (result) {
        case ApiSuccess<MoviesPageEntity>():
          searchResults = result.data.movies;
          searchMovieCount = result.data.totalCount;
          searchPageSize = result.data.limit;
          currentSearchPage = result.data.pageNumber;

          _emit(
            HomeLoaded(
              selectedTapIndex: selectedTapIndex,
              carouselIndex: currentCarouselIndex,
              selectedGenre: selectedGenre,
            ),
          );

        case ApiError<MoviesPageEntity>():
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
    });
  } // ---------------------------------------------------------------------------
  // Genre
  // ---------------------------------------------------------------------------

  Future<void> onGenreSelected(String genre) async {
    if (selectedGenre == genre) return;
    selectedGenre = genre;
    await _loadGenreMovies(genre);
  }

  Future<void> openExploreForGenre(String genre) async {
    _searchDebounce?.cancel();
    searchController.clear();
    searchResults.clear();
    _params = const GetMoviesParams(page: 1, limit: 20);
    selectedGenre = genre;
    selectedTapIndex = 2;
    filteredMovies.clear();
    exploreMovieCount = 0;
    currentExplorePage = 1;

    _emit(
      HomeTapIndexUpdated(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );

    await _loadGenreMovies(genre);
  }

  Future<void> _loadGenreMovies(String genre) async {
    _emit(
      HomeLoading(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );

    final result = await _getMoviesUseCase.call(
      GetMoviesParams(page: 1, limit: 20, genre: genre),
    );

    if (selectedGenre != genre || isClosed) return;

    switch (result) {
      case ApiSuccess<MoviesPageEntity>():
        filteredMovies = result.data.movies;
        exploreMovieCount = result.data.totalCount;
        explorePageSize = result.data.limit;
        currentExplorePage = result.data.pageNumber;
        break;
      case ApiError<MoviesPageEntity>():
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

  Future<MoviesPageEntity> fetchSearchPage(int page) async {
    final query = searchController.text.trim();
    final result = await _getMoviesUseCase.call(
      GetMoviesParams(page: page, limit: 20, queryTerm: query),
    );
    return switch (result) {
      ApiSuccess<MoviesPageEntity>(:final data) => data,
      ApiError<MoviesPageEntity>(:final message) => throw StateError(message),
    };
  }

  Future<MoviesPageEntity> fetchExplorePage(int page) async {
    final genre = selectedGenre;
    if (genre == null) {
      throw StateError('A genre must be selected before loading its movies.');
    }
    final result = await _getMoviesUseCase.call(
      GetMoviesParams(page: page, limit: 20, genre: genre),
    );
    return switch (result) {
      ApiSuccess<MoviesPageEntity>(:final data) => data,
      ApiError<MoviesPageEntity>(:final message) => throw StateError(message),
    };
  }

  void updateSearchPage(MoviesPageEntity page, List<MovieEntity> allMovies) {
    searchResults
      ..clear()
      ..addAll(allMovies);
    searchMovieCount = page.totalCount;
    searchPageSize = page.limit;
    currentSearchPage = page.pageNumber;
    _emit(
      HomeLoaded(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );
  }

  void updateExplorePage(MoviesPageEntity page, List<MovieEntity> allMovies) {
    filteredMovies
      ..clear()
      ..addAll(allMovies);
    exploreMovieCount = page.totalCount;
    explorePageSize = page.limit;
    currentExplorePage = page.pageNumber;
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

    _params = const GetMoviesParams(page: 1, limit: 20);

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
    if (selectedTapIndex != 0 && index == 0) {
      _refreshHomeGenreSections();
    }
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

  void changeProfileTab(int index) {
    selectedProfileTabIndex = index;
    _emit(
      HomeProfileTabUpdated(
        selectedTapIndex: selectedTapIndex,
        carouselIndex: currentCarouselIndex,
        selectedGenre: selectedGenre,
      ),
    );
  }

  Stream<List<MovieEntity>> watchlistStream() =>
      _firebaseAuthService.watchlistStream();

  Stream<List<MovieEntity>> historyStream() =>
      _firebaseAuthService.historyStream();

  Future<void> addToWatchlist(MovieEntity movie) =>
      _firebaseAuthService.addToWatchlist(movie);

  Future<void> removeFromWatchlist(String movieId) =>
      _firebaseAuthService.removeFromWatchlist(movieId);

  Future<void> addToHistory(MovieEntity movie) =>
      _firebaseAuthService.addToHistory(movie);

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
