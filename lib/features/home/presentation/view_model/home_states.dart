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
    selectedTapIndex: selectedIndex ?? selectedTapIndex,
    carouselIndex: carouselIndex ?? this.carouselIndex,
  );
}

class HomeLoading extends HomeStates {
  const HomeLoading({super.selectedTapIndex, super.carouselIndex});

  @override
  HomeLoading copyWith({int? selectedIndex, int? carouselIndex}) => HomeLoading(
    selectedTapIndex: selectedIndex ?? selectedTapIndex,
    carouselIndex: carouselIndex ?? this.carouselIndex,
  );
}

class HomeTapIndexUpdated extends HomeStates {
  const HomeTapIndexUpdated({super.selectedTapIndex, super.carouselIndex});

  @override
  HomeTapIndexUpdated copyWith({int? selectedIndex, int? carouselIndex}) =>
      HomeTapIndexUpdated(
        selectedTapIndex: selectedIndex ?? selectedTapIndex,
        carouselIndex: carouselIndex ?? this.carouselIndex,
      );
}

class HomeCarouselIndexUpdated extends HomeStates {
  const HomeCarouselIndexUpdated({super.selectedTapIndex, super.carouselIndex});

  @override
  HomeCarouselIndexUpdated copyWith({int? selectedIndex, int? carouselIndex}) =>
      HomeCarouselIndexUpdated(
        selectedTapIndex: selectedIndex ?? selectedTapIndex,
        carouselIndex: carouselIndex ?? this.carouselIndex,
      );
}

class HomeLoaded extends HomeStates {
  const HomeLoaded({super.selectedTapIndex, super.carouselIndex});

  @override
  HomeStates copyWith({int? selectedIndex, int? carouselIndex}) => HomeLoaded(
    selectedTapIndex: selectedIndex ?? selectedTapIndex,
    carouselIndex: carouselIndex ?? this.carouselIndex,
  );
}

class HomeFailed extends HomeStates {
  const HomeFailed({required this.message, super.selectedTapIndex, super.carouselIndex});

  final String message;

  @override
  HomeStates copyWith({int? selectedIndex, int? carouselIndex,String? message}) => HomeFailed(
    selectedTapIndex: selectedIndex ?? selectedTapIndex,
    carouselIndex: carouselIndex ?? this.carouselIndex,
    message: message ?? this.message,
  );
}
