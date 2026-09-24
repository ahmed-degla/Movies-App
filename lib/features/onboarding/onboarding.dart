import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:movies/core/routing/app_router.gr.dart';
import 'package:movies/generated/assets/assets.gen.dart';
import 'package:shared_preferences/shared_preferences.dart';

@RoutePage()
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: Colors.black,
    body: PageView(
      controller: _controller,
      onPageChanged: (index) {
        setState(() {
          _currentIndex = index;
        });
      },
      children: [
        _buildPage(
          image: Assets.images.png.onboarding1.image(fit: BoxFit.cover),
          title: 'Find Your Next Favorite Movie Here',
          description:
          'Get access to a huge library of movies to suit all tastes. You will always find something to watch.',
        ),
        _buildPage(
          image: Assets.images.png.onboarding2.image(fit: BoxFit.cover),
          title: 'Discover Movies',
          description:
          'Explore a vast collection of movies in all genres. Find something new and exciting to watch every day.',
        ),
        _buildPage(
          image: Assets.images.png.onboarding3.image(fit: BoxFit.cover),
          title: 'Explore All Genres',
          description:
          'Discover movies from every genre, in all available qualities. Find something new and exciting to watch every day.',
        ),
        _buildPage(
          image: Assets.images.png.onboarding4.image(fit: BoxFit.cover),
          title: 'Create Watchlists',
          description:
          'Save movies to your watchlist so you never lose track of what you want to watch. Enjoy seamless watchlists with friends.',
        ),
        _buildPage(
          image: Assets.images.png.onboarding5.image(fit: BoxFit.cover),
          title: 'Rate, Review, and Share',
          description:
          'Share your thoughts on the movies you have watched. Rate movies and discuss details with your friends.',
        ),
        _buildPage(
          image: Assets.images.png.onboarding6.image(fit: BoxFit.cover),
          title: 'Start Watching Now',
          description:
          'Enjoy unlimited movies and TV shows anytime, anywhere. Start your journey now.',
        ),
      ],
    ),
  );

  Widget _buildPage({
    required Widget image,
    required String title,
    required String description,
  }) =>
      Stack(
        children: [
          Positioned.fill(child: image),
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.85),
                    Colors.black,
                  ],
                  stops: const [0.3, 0.7, 1.0],
                ),
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: 20.0, vertical: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    description,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFBB3B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () async {
                        if (_currentIndex == 5) {
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setBool('onboarding_completed', true);

                          if (!mounted) return;
                          context.router.replace(const SignInRoute());
                        } else {
                          unawaited(_controller.nextPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ));
                        }
                      },
                      child: Text(
                        _currentIndex == 5 ? 'Explore Now' : 'Next',
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  if (_currentIndex > 0)
                    SizedBox(
                      width: double.infinity,
                      height: 48,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFFFFBB3B)),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          unawaited(_controller.previousPage(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          ));
                        },
                        child: const Text(
                          'Back',
                          style: TextStyle(
                            color: Color(0xFFFFBB3B),
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  else
                    const SizedBox(height: 48),
                ],
              ),
            ),
          ),
        ],
      );
}