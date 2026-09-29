import 'package:flutter_test/flutter_test.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/movie_details/data/model/movie_details_model.dart';
import 'package:movies/features/movie_details/domain/entity/cast_member_entity.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/domain/entity/similar_movie_entity.dart';
import 'package:movies/features/movie_details/domain/repo/movie_details_repo.dart';
import 'package:movies/features/movie_details/domain/use_cases/add_to_history_use_case.dart';
import 'package:movies/features/movie_details/domain/use_cases/get_movie_details_use_case.dart';
import 'package:movies/features/movie_details/domain/use_cases/toggle_bookmark_use_case.dart';
import 'package:movies/features/movie_details/presentation/view_model/movie_details_cubit.dart';

class FakeMovieDetailsRepo implements MovieDetailsRepo {
  bool isBookmarkedState = false;
  MovieDetailsEntity? addedToHistoryMovie;
  ApiResult<MovieDetailsEntity>? getMovieDetailsResult;
  ApiResult<bool>? toggleBookmarkResult;
  ApiResult<void>? addToHistoryResult;

  @override
  FutureApiResult<MovieDetailsEntity> getMovieDetails(int movieId) async =>
      getMovieDetailsResult ??
      ApiSuccess(
        data: MovieDetailsEntity(
          id: movieId,
          title: 'Test Movie',
          releaseYear: 2024,
          backdropImage: 'https://example.com/backdrop.jpg',
          posterImage: 'https://example.com/poster.jpg',
          rating: 8.5,
          runtime: 120,
          likesCount: 1500,
          summary: 'A test movie summary.',
          screenshots: const ['https://example.com/s1.jpg'],
          genres: const ['Action', 'Sci-Fi'],
          cast: const [
            CastMemberEntity(
              name: 'John Doe',
              characterName: 'Hero',
              avatarImage: 'https://example.com/actor.jpg',
            ),
          ],
          similarMovies: const [
            SimilarMovieEntity(
              id: 999,
              title: 'Similar Title',
              posterImage: 'https://example.com/similar.jpg',
              rating: 7.9,
            ),
          ],
          isBookmarked: isBookmarkedState,
          trailerCode: 'dQw4w9WgXcQ',
        ),
      );

  @override
  FutureApiResult<bool> toggleBookmark(MovieDetailsEntity movie) async {
    if (toggleBookmarkResult != null) return toggleBookmarkResult!;
    isBookmarkedState = !isBookmarkedState;
    return ApiSuccess(data: isBookmarkedState);
  }

  @override
  FutureApiResult<void> addToHistory(MovieDetailsEntity movie) async {
    addedToHistoryMovie = movie;
    return addToHistoryResult ?? const ApiSuccess<void>(data: null);
  }
}

void main() {
  group('MovieDetailsModel parsing tests', () {
    test('parses complete JSON safely without throwing', () {
      final json = {
        'id': 12345,
        'title': 'Inception',
        'year': 2010,
        'background_image_original': 'https://example.com/bg.jpg',
        'large_cover_image': 'https://example.com/cover.jpg',
        'rating': 8.8,
        'runtime': 148,
        'like_count': 25000,
        'description_full': 'A mind-bending thriller.',
        'large_screenshot_image1': 'https://example.com/screen1.jpg',
        'genres': ['Action', 'Adventure', 'Sci-Fi'],
        'yt_trailer_code': 'YoHD9XEInc0',
        'cast': [
          {
            'name': 'Leonardo DiCaprio',
            'character_name': 'Cobb',
            'url_small_image': 'https://example.com/leo.jpg',
          },
        ],
      };

      final model = MovieDetailsModel.fromJson(json);

      expect(model.id, 12345);
      expect(model.title, 'Inception');
      expect(model.releaseYear, 2010);
      expect(model.backdropImage, 'https://example.com/bg.jpg');
      expect(model.posterImage, 'https://example.com/cover.jpg');
      expect(model.rating, 8.8);
      expect(model.runtime, 148);
      expect(model.likesCount, 25000);
      expect(model.summary, 'A mind-bending thriller.');
      expect(model.screenshots, contains('https://example.com/screen1.jpg'));
      expect(model.genres, contains('Action'));
      expect(model.trailerCode, 'YoHD9XEInc0');
      expect(model.cast.length, 1);
      expect(model.cast.first.name, 'Leonardo DiCaprio');
    });

    test(
      'handles nulls, missing fields, and type mismatches with fallbacks',
      () {
        final json = <String, dynamic>{
          'id': '999',
          'rating': '7.5',
          'year': '2022',
          'runtime': '105',
          'like_count': '300',
        };

        final model = MovieDetailsModel.fromJson(json);

        expect(model.id, 999);
        expect(model.title, '');
        expect(model.releaseYear, 2022);
        expect(model.rating, 7.5);
        expect(model.runtime, 105);
        expect(model.likesCount, 300);
        expect(model.summary, '');
        expect(model.screenshots, isEmpty);
        expect(model.genres, isEmpty);
        expect(model.cast, isEmpty);
        expect(model.trailerCode, '');
        expect(model.isBookmarked, isFalse);
      },
    );
  });

  group('MovieDetailsCubit & Actions tests', () {
    late FakeMovieDetailsRepo fakeRepo;
    late GetMovieDetailsUseCase getMovieDetailsUseCase;
    late ToggleBookmarkUseCase toggleBookmarkUseCase;
    late AddToHistoryUseCase addToHistoryUseCase;
    late MovieDetailsCubit cubit;

    setUp(() {
      fakeRepo = FakeMovieDetailsRepo();
      getMovieDetailsUseCase = GetMovieDetailsUseCase(fakeRepo);
      toggleBookmarkUseCase = ToggleBookmarkUseCase(fakeRepo);
      addToHistoryUseCase = AddToHistoryUseCase(fakeRepo);
      cubit = MovieDetailsCubit(
        getMovieDetailsUseCase,
        toggleBookmarkUseCase,
        addToHistoryUseCase,
      );
    });

    tearDown(() async {
      await cubit.close();
    });

    test('fetchMovieDetails emits Loading and Loaded on success', () async {
      expect(cubit.state, isA<MovieDetailsInit>());

      final future = cubit.fetchMovieDetails(100);
      expect(cubit.state, isA<MovieDetailsLoading>());

      await future;

      expect(cubit.state, isA<MovieDetailsLoaded>());
      final loadedState = cubit.state as MovieDetailsLoaded;
      expect(loadedState.movie.id, 100);
      expect(loadedState.movie.title, 'Test Movie');
      expect(loadedState.movie.trailerCode, 'dQw4w9WgXcQ');
    });

    test('fetchMovieDetails emits Loading and Error on failure', () async {
      fakeRepo.getMovieDetailsResult = const ApiError(
        message: 'Failed to load',
      );

      await cubit.fetchMovieDetails(100);

      expect(cubit.state, isA<MovieDetailsError>());
      final errorState = cubit.state as MovieDetailsError;
      expect(errorState.message, 'Failed to load');
    });

    test('toggleBookmark persists and updates movie.isBookmarked', () async {
      await cubit.fetchMovieDetails(100);
      final initialLoaded = cubit.state as MovieDetailsLoaded;
      expect(initialLoaded.movie.isBookmarked, isFalse);

      await cubit.toggleBookmark();

      final updatedLoaded = cubit.state as MovieDetailsLoaded;
      expect(updatedLoaded.movie.isBookmarked, isTrue);
      expect(fakeRepo.isBookmarkedState, isTrue);

      await cubit.toggleBookmark();

      final toggledBack = cubit.state as MovieDetailsLoaded;
      expect(toggledBack.movie.isBookmarked, isFalse);
      expect(fakeRepo.isBookmarkedState, isFalse);
    });

    test('addToHistory calls use case with current movie', () async {
      await cubit.fetchMovieDetails(100);
      await cubit.addToHistory();

      expect(fakeRepo.addedToHistoryMovie, isNotNull);
      expect(fakeRepo.addedToHistoryMovie!.id, 100);
      expect(fakeRepo.addedToHistoryMovie!.title, 'Test Movie');
    });
  });
}
