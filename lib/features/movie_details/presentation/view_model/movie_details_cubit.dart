import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:movies/core/firebase_service/firebase_auth_service.dart';
import 'package:movies/core/network/api_result.dart';
import 'package:movies/features/home/domain/entity/movie_entity.dart';
import 'package:movies/features/movie_details/data/model/movie_details_params.dart';
import 'package:movies/features/movie_details/domain/entity/movie_details_entity.dart';
import 'package:movies/features/movie_details/domain/use_cases/get_movie_details_use_case.dart';
import 'package:movies/features/movie_details/domain/use_cases/get_movie_suggestions_use_case.dart';

part 'movie_details_states.dart';

@injectable
class MovieDetailsCubit extends Cubit<MovieDetailsState> {
  MovieDetailsCubit(
    this._getMovieDetailsUseCase,
    this._getMovieSuggestionsUseCase,
    this._firebaseAuthService,
  ) : super(const MovieDetailsInitial());

  final GetMovieDetailsUseCase _getMovieDetailsUseCase;
  final GetMovieSuggestionsUseCase _getMovieSuggestionsUseCase;
  final FirebaseAuthService _firebaseAuthService;

  static MovieDetailsCubit of(BuildContext context) =>
      context.read<MovieDetailsCubit>();

  StreamSubscription<List<MovieEntity>>? _watchlistSubscription;
  MovieDetailsEntity? _currentMovie;

  Future<void> loadMovieDetails(int movieId) async {
    emit(const MovieDetailsLoading());

    final movieDetailsResult = await _getMovieDetailsUseCase.call(
      GetMovieDetailsParams(
        movieId: movieId,
      ),
    );

    switch (movieDetailsResult) {
      case ApiSuccess<MovieDetailsEntity>(:final data):
        _currentMovie = data;

        try {
          if (_firebaseAuthService.isAuthenticated) {
            unawaited(_firebaseAuthService.addToHistory(data.toMovieEntity()));
          }
        } on Object catch (_) {}

        var suggestions = <MovieEntity>[];
        final suggestionsResult =
            await _getMovieSuggestionsUseCase.call(movieId);
        if (suggestionsResult is ApiSuccess<List<MovieEntity>>) {
          suggestions = suggestionsResult.data;
        }

        var isWatchlist = false;
        if (_firebaseAuthService.isAuthenticated) {
          try {
            final watchlist =
                await _firebaseAuthService.watchlistStream().first;
            isWatchlist =
                watchlist.any((m) => m.id == data.id.toString());
          } on Object catch (_) {}
        }

        emit(
          MovieDetailsLoaded(
            movie: data,
            suggestions: suggestions,
            isWatchlist: isWatchlist,
          ),
        );

        _listenToWatchlist(data.id.toString());

      case ApiError<MovieDetailsEntity>(:final message):
        emit(MovieDetailsError(message: message));
    }
  }

  void _listenToWatchlist(String movieId) {
    if (!_firebaseAuthService.isAuthenticated) return;
    unawaited(_watchlistSubscription?.cancel());
    _watchlistSubscription =
        _firebaseAuthService.watchlistStream().listen((watchlist) {
      if (state is MovieDetailsLoaded) {
        final current = state as MovieDetailsLoaded;
        final isInWatchlist = watchlist.any((m) => m.id == movieId);
        if (current.isWatchlist != isInWatchlist) {
          emit(current.copyWith(isWatchlist: isInWatchlist));
        }
      }
    });
  }

  Future<void> toggleWatchlist() async {
    if (state is! MovieDetailsLoaded || _currentMovie == null) return;
    final currentState = state as MovieDetailsLoaded;
    final movie = _currentMovie!;

    if (!_firebaseAuthService.isAuthenticated) return;

    try {
      if (currentState.isWatchlist) {
        emit(currentState.copyWith(isWatchlist: false));
        await _firebaseAuthService.removeFromWatchlist(movie.id.toString());
      } else {
        emit(currentState.copyWith(isWatchlist: true));
        await _firebaseAuthService.addToWatchlist(movie.toMovieEntity());
      }
    } on Object catch (_) {
      emit(currentState);
    }
  }

  @override
  Future<void> close() {
    unawaited(_watchlistSubscription?.cancel());
    return super.close();
  }
}
