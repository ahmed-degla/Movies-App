part of 'home_cubit.dart';

sealed class HomeStates {
  const HomeStates({
    this.selectedTapIndex = 0,
    this.carouselIndex = 0,
    this.selectedGenre,
  });

  final int selectedTapIndex;
  final int carouselIndex;
  final String? selectedGenre;

  HomeStates copyWith({
    int? selectedTapIndex,
    int? carouselIndex,
    String? selectedGenre,
  });
}

class HomeInit extends HomeStates {
  const HomeInit({
    super.selectedTapIndex,
    super.carouselIndex,
    super.selectedGenre,
  });

  @override
  HomeInit copyWith({
    int? selectedTapIndex,
    int? carouselIndex,
    String? selectedGenre,
  }) => HomeInit(
      selectedTapIndex: selectedTapIndex ?? this.selectedTapIndex,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
}

class HomeLoading extends HomeStates {
  const HomeLoading({
    super.selectedTapIndex,
    super.carouselIndex,
    super.selectedGenre,
  });

  @override
  HomeLoading copyWith({
    int? selectedTapIndex,
    int? carouselIndex,
    String? selectedGenre,
  }) => HomeLoading(
      selectedTapIndex: selectedTapIndex ?? this.selectedTapIndex,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
}

class HomeLoaded extends HomeStates {
  const HomeLoaded({
    super.selectedTapIndex,
    super.carouselIndex,
    super.selectedGenre,
  });

  @override
  HomeLoaded copyWith({
    int? selectedTapIndex,
    int? carouselIndex,
    String? selectedGenre,
  }) => HomeLoaded(
      selectedTapIndex: selectedTapIndex ?? this.selectedTapIndex,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
}

class HomeTapIndexUpdated extends HomeStates {
  const HomeTapIndexUpdated({
    super.selectedTapIndex,
    super.carouselIndex,
    super.selectedGenre,
  });

  @override
  HomeTapIndexUpdated copyWith({
    int? selectedTapIndex,
    int? carouselIndex,
    String? selectedGenre,
  }) => HomeTapIndexUpdated(
      selectedTapIndex: selectedTapIndex ?? this.selectedTapIndex,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
}

class HomeCarouselIndexUpdated extends HomeStates {
  const HomeCarouselIndexUpdated({
    super.selectedTapIndex,
    super.carouselIndex,
    super.selectedGenre,
  });

  @override
  HomeCarouselIndexUpdated copyWith({
    int? selectedTapIndex,
    int? carouselIndex,
    String? selectedGenre,
  }) => HomeCarouselIndexUpdated(
      selectedTapIndex: selectedTapIndex ?? this.selectedTapIndex,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
}

class HomeGenreSelected extends HomeStates {
  const HomeGenreSelected({
    super.selectedTapIndex,
    super.carouselIndex,
    super.selectedGenre,
  });

  @override
  HomeGenreSelected copyWith({
    int? selectedTapIndex,
    int? carouselIndex,
    String? selectedGenre,
  }) => HomeGenreSelected(
      selectedTapIndex: selectedTapIndex ?? this.selectedTapIndex,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
    );
}

class HomeFailed extends HomeStates {
  const HomeFailed({
    required this.message,
    super.selectedTapIndex,
    super.carouselIndex,
    super.selectedGenre,
  });

  final String message;

  @override
  HomeFailed copyWith({
    int? selectedTapIndex,
    int? carouselIndex,
    String? selectedGenre,
    String? message,
  }) => HomeFailed(
      selectedTapIndex: selectedTapIndex ?? this.selectedTapIndex,
      carouselIndex: carouselIndex ?? this.carouselIndex,
      selectedGenre: selectedGenre ?? this.selectedGenre,
      message: message ?? this.message,
    );
}