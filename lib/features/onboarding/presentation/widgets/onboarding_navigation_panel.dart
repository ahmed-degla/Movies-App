import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';

class OnboardingNavigationPanel extends StatelessWidget {
  const OnboardingNavigationPanel({
    required this.state,
    required this.onNext,
    required this.onBack,
    required this.onFinish,
    super.key,
  });

  final OnboardingState state;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
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
                  ? onFinish
                  : onNext,
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
                onTap: state.isCompleting ? null : onBack,
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
