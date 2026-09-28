import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'package:movies/features/onboarding/domain/use_cases/mark_onboarding_completed_use_case.dart';

class OnboardingState {
  const OnboardingState({
    this.currentPage = 0,
    this.isCompleting = false,
    this.isCompleted = false,
    this.hasError = false,
  });

  final int currentPage;
  final bool isCompleting;
  final bool isCompleted;
  final bool hasError;

  OnboardingState copyWith({
    int? currentPage,
    bool? isCompleting,
    bool? isCompleted,
    bool? hasError,
  }) => OnboardingState(
    currentPage: currentPage ?? this.currentPage,
    isCompleting: isCompleting ?? this.isCompleting,
    isCompleted: isCompleted ?? this.isCompleted,
    hasError: hasError ?? this.hasError,
  );
}

@Injectable()
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._markOnboardingCompleted)
    : pageController = PageController(),
      super(const OnboardingState());

  static const int pageCount = 6;

  final MarkOnboardingCompletedUseCase _markOnboardingCompleted;
  final PageController pageController;

  Future<void> goToPage(int page) => pageController.animateToPage(
    page,
    duration: const Duration(milliseconds: 380),
    curve: Curves.easeInOutCubic,
  );

  void onPageChanged(int page) {
    if (page < 0 || page >= pageCount || page == state.currentPage) return;
    emit(state.copyWith(currentPage: page, hasError: false));
  }

  Future<void> completeOnboarding() async {
    if (state.isCompleting || state.isCompleted) return;

    emit(state.copyWith(isCompleting: true, hasError: false));

    try {
      await _markOnboardingCompleted.call();
      emit(state.copyWith(isCompleting: false, isCompleted: true));
    } on Object catch (error, stackTrace) {
      addError(error, stackTrace);
      emit(state.copyWith(isCompleting: false, hasError: true));
    }
  }

  @override
  Future<void> close() {
    pageController.dispose();
    return super.close();
  }
}
