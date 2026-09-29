import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:movies/core/di/injection.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/onboarding/presentation/onboarding_page_content.dart';
import 'package:movies/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:movies/features/onboarding/presentation/widgets/onboarding_navigation_panel.dart';
import 'package:movies/features/onboarding/presentation/widgets/onboarding_page_background.dart';
import 'package:movies/widgets/app_snack_bar.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt.get<OnboardingCubit>(),
    child: const _OnboardingView(),
  );
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) {
    final localizations = tr;
    final pages = OnboardingPageContent.pages;

    return BlocListener<OnboardingCubit, OnboardingState>(
      listenWhen: (previous, current) =>
          previous.isCompleted != current.isCompleted ||
          previous.hasError != current.hasError,
      listener: (context, state) {
        if (state.isCompleted) {
          unawaited(context.router.replace(const SignInRoute()));
        } else if (state.hasError) {
          AppSnackBar.show(
            message: tr.onboardingError,
            type: AppSnackBarType.error,
          );
        }
      },
      child: BlocBuilder<OnboardingCubit, OnboardingState>(
        builder: (context, state) => Scaffold(
          body: Stack(
            children: [
              PageView.builder(
                controller: context.read<OnboardingCubit>().pageController,
                itemCount: pages.length,
                onPageChanged: context.read<OnboardingCubit>().onPageChanged,
                itemBuilder: (context, index) => OnboardingPageBackground(
                  pageController: context
                      .read<OnboardingCubit>()
                      .pageController,
                  image: pages[index].image.image(fit: BoxFit.cover),
                  index: index,
                  fallbackPage: state.currentPage,
                ),
              ),
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: OnboardingNavigationPanel(
                  state: state,
                  page: pages[state.currentPage],
                  localizations: localizations,
                  onNext: () => context.read<OnboardingCubit>().goToPage(
                    state.currentPage + 1,
                  ),
                  onBack: () => context.read<OnboardingCubit>().goToPage(
                    state.currentPage - 1,
                  ),
                  onFinish: context.read<OnboardingCubit>().completeOnboarding,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
