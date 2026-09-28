import 'dart:async';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';

import 'package:movies/core/di/injection.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';

@RoutePage()
class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  static final _images = [
    Assets.images.png.onboarding1,
    Assets.images.png.onboarding2,
    Assets.images.png.onboarding3,
    Assets.images.png.onboarding4,
    Assets.images.png.onboarding5,
    Assets.images.png.onboarding6,
  ];

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => getIt.get<OnboardingCubit>(),
    child: const _OnboardingView(),
  );
}

class _OnboardingView extends StatelessWidget {
  const _OnboardingView();

  @override
  Widget build(BuildContext context) =>
      BlocListener<OnboardingCubit, OnboardingState>(
        listenWhen: (previous, current) =>
            previous.isCompleted != current.isCompleted ||
            previous.hasError != current.hasError,
        listener: (context, state) {
          if (state.isCompleted) {
            unawaited(context.router.replace(const SignInRoute()));
          } else if (state.hasError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(tr.onboardingError)));
          }
        },
        child: BlocBuilder<OnboardingCubit, OnboardingState>(
          builder: (context, state) => Scaffold(
            body: Stack(
              children: [
                PageView.builder(
                  controller: context.read<OnboardingCubit>().pageController,
                  itemCount: OnboardingScreen._images.length,
                  onPageChanged: context.read<OnboardingCubit>().onPageChanged,
                  itemBuilder: (context, index) =>
                      _buildImagePage(context, index, state),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: _buildBottomBar(context, state),
                ),
              ],
            ),
            // bottomNavigationBar:
          ),
        ),
      );

  Widget _buildImagePage(
    BuildContext context,
    int index,
    OnboardingState state,
  ) {
    final pageController = context.read<OnboardingCubit>().pageController;

    return AnimatedBuilder(
      animation: pageController,
      child: OnboardingScreen._images[index].image(fit: BoxFit.cover),
      builder: (context, image) {
        final page = pageController.hasClients
            ? pageController.page ?? state.currentPage.toDouble()
            : state.currentPage.toDouble();
        final distance = (page - index).abs().clamp(0.0, 1.0);

        return Stack(
          fit: StackFit.expand,
          children: [
            Transform.scale(
              scale: 1.05 - distance * 0.05,
              child: Opacity(opacity: 1 - distance * 0.18, child: image),
            ),
            DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.12),
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.82),
                  ],
                  stops: const [0, 0.42, 1],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildBottomBar(BuildContext context, OnboardingState state) {
    final titles = [
      tr.onboardingTitle1,
      tr.onboardingTitle2,
      tr.onboardingTitle3,
      tr.onboardingTitle4,
      tr.onboardingTitle5,
      tr.onboardingTitle6,
    ];
    final descriptions = [
      tr.onboardingDescription1,
      tr.onboardingDescription2,
      tr.onboardingDescription3,
      tr.onboardingDescription4,
      tr.onboardingDescription5,
      tr.onboardingDescription6,
    ];
    final cubit = context.read<OnboardingCubit>();
    final isLastPage = state.currentPage == OnboardingCubit.pageCount - 1;

    return Container(
      padding: context.edgeInsets(horizontal: 24, top: 24, bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFF111111),
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(context.w(22)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 240),
              switchInCurve: Curves.easeOut,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, animation) => FadeTransition(
                opacity: animation,
                child: SlideTransition(
                  position: Tween<Offset>(
                    begin: const Offset(0, 0.12),
                    end: Offset.zero,
                  ).animate(animation),
                  child: child,
                ),
              ),
              child: Column(
                key: ValueKey(state.currentPage),
                children: [
                  AppText(
                    text: titles[state.currentPage],
                    fontSize: context.sp(24),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  if (descriptions[state.currentPage].isNotEmpty) ...[
                    SizedBox(height: context.h(20)),
                    AppText(
                      text: descriptions[state.currentPage],
                      fontSize: context.sp(20),
                      textAlign: TextAlign.center,
                      color: state.currentPage == 0
                          ? appColors.primaryText.withValues(alpha: 0.6)
                          : null,
                    ),
                  ],
                ],
              ),
            ),
            SizedBox(height: context.h(12)),

            AppButton(
              onTap: state.isCompleting
                  ? null
                  : isLastPage
                  ? cubit.completeOnboarding
                  : () => cubit.goToPage(state.currentPage + 1),
              loading: state.isCompleting,
              child: AppText(
                text: isLastPage
                    ? tr.onboardingFinish
                    : state.currentPage == 0
                    ? tr.onboardingExplore
                    : tr.onboardingNext,
                fontSize: context.sp(20),
                color: appColors.background,
                fontWeight: FontWeight.w600,
              ),
            ),
            if (state.currentPage > 0) ...[
              SizedBox(height: context.h(16)),
              AppButton.outlined(
                onTap: state.isCompleting
                    ? null
                    : () => cubit.goToPage(state.currentPage - 1),

                child: AppText(
                  text: tr.onboardingBack,
                  color: appColors.primary,
                  fontSize: context.sp(20),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
