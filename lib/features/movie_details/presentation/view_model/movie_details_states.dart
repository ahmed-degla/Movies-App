part of 'movie_details_cubit.dart';

sealed class MovieDetailsState {
  const MovieDetailsState();
}

class MovieDetailsInitial extends MovieDetailsState {
  const MovieDetailsInitial();
}

class MovieDetailsLoading extends MovieDetailsState {
  const MovieDetailsLoading();
}

class MovieDetailsLoaded extends MovieDetailsState {
  const MovieDetailsLoaded({
    required this.movie,
    this.suggestions = const [],
    this.isWatchlist = false,
  });

  final MovieDetailsEntity movie;
  final List<MovieEntity> suggestions;
  final bool isWatchlist;

  MovieDetailsLoaded copyWith({
    MovieDetailsEntity? movie,
    List<MovieEntity>? suggestions,
    bool? isWatchlist,
  }) =>
      MovieDetailsLoaded(
        movie: movie ?? this.movie,
        suggestions: suggestions ?? this.suggestions,
        isWatchlist: isWatchlist ?? this.isWatchlist,
      );
}

class MovieDetailsError extends MovieDetailsState {
  const MovieDetailsError({required this.message});

  final String message;
}
