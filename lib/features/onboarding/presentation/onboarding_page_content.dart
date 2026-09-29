import 'package:movies/generated/assets/assets.gen.dart';
import 'package:movies/generated/l10n/app_localizations.dart';

class OnboardingPageContent {
  const OnboardingPageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  final AssetGenImage image;
  final String Function(AppLocalizations localizations) title;
  final String Function(AppLocalizations localizations) description;

  static final List<OnboardingPageContent> pages = List.unmodifiable([
    OnboardingPageContent(
      image: Assets.images.png.onboarding1,
      title: (localizations) => localizations.onboardingTitle1,
      description: (localizations) => localizations.onboardingDescription1,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding2,
      title: (localizations) => localizations.onboardingTitle2,
      description: (localizations) => localizations.onboardingDescription2,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding3,
      title: (localizations) => localizations.onboardingTitle3,
      description: (localizations) => localizations.onboardingDescription3,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding4,
      title: (localizations) => localizations.onboardingTitle4,
      description: (localizations) => localizations.onboardingDescription4,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding5,
      title: (localizations) => localizations.onboardingTitle5,
      description: (localizations) => localizations.onboardingDescription5,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding6,
      title: (localizations) => localizations.onboardingTitle6,
      description: (localizations) => localizations.onboardingDescription6,
    ),
  ]);

  static int get pageCount => pages.length;
}
