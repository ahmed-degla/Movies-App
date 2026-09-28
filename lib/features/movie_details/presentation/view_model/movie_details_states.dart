part of 'movie_details_cubit.dart';

sealed class MovieDetailsStates {
  const MovieDetailsStates();

  MovieDetailsStates copyWith();
}

class MovieDetailsInit extends MovieDetailsStates {
  const MovieDetailsInit();

  @override
  MovieDetailsInit copyWith() => const MovieDetailsInit();
}

class MovieDetailsLoading extends MovieDetailsStates {
  const MovieDetailsLoading();

  @override
  MovieDetailsLoading copyWith() => const MovieDetailsLoading();
}

class MovieDetailsLoaded extends MovieDetailsStates {
  const MovieDetailsLoaded({required this.movie, this.isBookmarking = false});

  final MovieDetailsEntity movie;
  final bool isBookmarking;

  @override
  MovieDetailsLoaded copyWith({
    MovieDetailsEntity? movie,
    bool? isBookmarking,
  }) =>
      MovieDetailsLoaded(
        movie: movie ?? this.movie,
        isBookmarking: isBookmarking ?? this.isBookmarking,
      );
}

class MovieDetailsError extends MovieDetailsStates {
  const MovieDetailsError({required this.message});

  final String message;

  @override
  MovieDetailsError copyWith({String? message}) =>
      MovieDetailsError(message: message ?? this.message);
}
