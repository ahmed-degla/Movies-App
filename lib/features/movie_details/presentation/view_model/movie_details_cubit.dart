import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/domain/use_cases/add_to_history_use_case.dart';
import 'package:movies/features/movie_details/domain/use_cases/get_movie_details_use_case.dart';
import 'package:movies/features/movie_details/domain/use_cases/toggle_bookmark_use_case.dart';
import 'package:movies/widgets/app_snack_bar.dart';

part 'movie_details_states.dart';

@Injectable()
class MovieDetailsCubit extends Cubit<MovieDetailsStates> {
  MovieDetailsCubit(
    this._getMovieDetailsUseCase,
    this._toggleBookmarkUseCase,
    this._addToHistoryUseCase,
  ) : super(const MovieDetailsInit());

  final GetMovieDetailsUseCase _getMovieDetailsUseCase;
  final ToggleBookmarkUseCase _toggleBookmarkUseCase;
  final AddToHistoryUseCase _addToHistoryUseCase;

  static MovieDetailsCubit of(BuildContext context) =>
      context.read<MovieDetailsCubit>();

  Future<void> fetchMovieDetails(int movieId) async {
    emit(const MovieDetailsLoading());

    final result = await _getMovieDetailsUseCase(movieId);

    switch (result) {
      case ApiSuccess(:final data):
        emit(MovieDetailsLoaded(movie: data));
      case ApiError(:final message):
        emit(MovieDetailsError(message: message));
    }
  }

  Future<void> toggleBookmark() async {
    final currentState = state;
    if (currentState is! MovieDetailsLoaded) {
      return;
    }

    final movie = currentState.movie;
    emit(currentState.copyWith(isBookmarking: true));

    final result = await _toggleBookmarkUseCase(movie);

    switch (result) {
      case ApiSuccess(:final data):
        emit(
          currentState.copyWith(
            movie: movie.copyWith(isBookmarked: data),
            isBookmarking: false,
          ),
        );
      case ApiError():
        emit(currentState.copyWith(isBookmarking: false));
        AppSnackBar.show(
          message: tr.movieDetailsBookmarkFailed,
          type: AppSnackBarType.error,
        );
    }
  }

  Future<void> addToHistory() async {
    final currentState = state;
    if (currentState is! MovieDetailsLoaded) {
      return;
    }

    final result = await _addToHistoryUseCase(currentState.movie);
    switch (result) {
      case ApiSuccess():
        return;
      case ApiError():
        AppSnackBar.show(
          message: tr.movieDetailsWatchFailed,
          type: AppSnackBarType.error,
        );
    }
  }
}
