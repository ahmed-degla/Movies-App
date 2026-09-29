import 'package:flutter/material.dart';

class OnboardingPageBackground extends StatelessWidget {
  const OnboardingPageBackground({
    required this.pageController,
    required this.image,
    required this.index,
    required this.fallbackPage,
    super.key,
  });

  final PageController pageController;
  final Widget image;
  final int index;
  final int fallbackPage;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: pageController,
    child: image,
    builder: (context, image) {
      final page = pageController.hasClients
          ? pageController.page ?? fallbackPage.toDouble()
          : fallbackPage.toDouble();
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
