part of 'home_cubit.dart';

sealed class HomeStates {
  const HomeStates({this.selectedTapIndex = 0, this.carouselIndex = 0});

  /// Bottom navigation index.
  final int selectedTapIndex;

  /// Carousel current index.
  final int carouselIndex;

  HomeStates copyWith({int? selectedIndex, int? carouselIndex});
}

class HomeInit extends HomeStates {
  const HomeInit({super.selectedTapIndex, super.carouselIndex});

  @override
  HomeInit copyWith({int? selectedIndex, int? carouselIndex}) => HomeInit(
    selectedTapIndex: selectedIndex ?? this.selectedTapIndex,
    carouselIndex: carouselIndex ?? this.carouselIndex,
  );
}

class HomeLoading extends HomeStates {
  const HomeLoading({super.selectedTapIndex, super.carouselIndex});

  @override
  HomeLoading copyWith({int? selectedIndex, int? carouselIndex}) => HomeLoading(
    selectedTapIndex: selectedIndex ?? this.selectedTapIndex,
    carouselIndex: carouselIndex ?? this.carouselIndex,
  );
}

class HomeTapIndexUpdated extends HomeStates {
  const HomeTapIndexUpdated({super.selectedTapIndex, super.carouselIndex});

  @override
  HomeTapIndexUpdated copyWith({int? selectedIndex, int? carouselIndex}) =>
      HomeTapIndexUpdated(
        selectedTapIndex: selectedIndex ?? this.selectedTapIndex,
        carouselIndex: carouselIndex ?? this.carouselIndex,
      );
}

class HomeCarouselIndexUpdated extends HomeStates {
  const HomeCarouselIndexUpdated({super.selectedTapIndex, super.carouselIndex});

  @override
  HomeCarouselIndexUpdated copyWith({int? selectedIndex, int? carouselIndex}) =>
      HomeCarouselIndexUpdated(
        selectedTapIndex: selectedIndex ?? this.selectedTapIndex,
        carouselIndex: carouselIndex ?? this.carouselIndex,
      );
}
