import 'package:flutter/material.dart';
import 'package:flutter_screenutil_plus/flutter_screenutil_plus.dart';
import 'package:movies/core/theme/theme_extension.dart';
import 'package:movies/features/onboarding/presentation/onboarding_page_content.dart';
import 'package:movies/features/onboarding/presentation/view_model/onboarding_cubit.dart';
import 'package:movies/generated/l10n/app_localizations.dart';
import 'package:movies/widgets/app_button.dart';
import 'package:movies/widgets/app_text.dart';

class OnboardingNavigationPanel extends StatelessWidget {
  const OnboardingNavigationPanel({
    required this.state,
    required this.page,
    required this.localizations,
    required this.onNext,
    required this.onBack,
    required this.onFinish,
    super.key,
  });

  final OnboardingState state;
  final OnboardingPageContent page;
  final AppLocalizations localizations;
  final VoidCallback onNext;
  final VoidCallback onBack;
  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
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
                    text: page.title(localizations),
                    fontSize: context.sp(24),
                    fontWeight: FontWeight.bold,
                    textAlign: TextAlign.center,
                  ),
                  if (page.description(localizations).isNotEmpty) ...[
                    SizedBox(height: context.h(20)),
                    AppText(
                      text: page.description(localizations),
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
                    ? localizations.onboardingFinish
                    : state.currentPage == 0
                    ? localizations.onboardingExplore
                    : localizations.onboardingNext,
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
                  text: localizations.onboardingBack,
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
