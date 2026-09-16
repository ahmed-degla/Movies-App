import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_states.dart';

class HomeCubit extends Cubit<HomeStates> {
  HomeCubit() : super(const HomeInit());

  static HomeCubit of(BuildContext context) => BlocProvider.of(context);

  int currentCarouselIndex = 0;

  void changeIndex(int index) {
    _emit(const HomeTapIndexUpdated().copyWith(selectedIndex: index));
  }

  void changeCarouselIndex(int index) {
    currentCarouselIndex = index;
    _emit(const HomeCarouselIndexUpdated().copyWith(carouselIndex: index));
  }

  bool get isStateLoading => state is HomeLoading;

  void _emit(HomeStates state) {
    if (!isClosed) {
      emit(state);
    }
  }
}
