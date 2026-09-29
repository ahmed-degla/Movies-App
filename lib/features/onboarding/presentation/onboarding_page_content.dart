import 'package:movies/core/utils/app_utils.dart';
import 'package:movies/generated/assets/assets.gen.dart';

class OnboardingPageContent {
  const OnboardingPageContent({
    required this.image,
    required this.title,
    required this.description,
  });

  final AssetGenImage image;
  final String  title;
  final String  description;

  static final List<OnboardingPageContent> pages = List.unmodifiable([
    OnboardingPageContent(
      image: Assets.images.png.onboarding1,
      title:  tr.onboardingTitle1,
      description:  tr.onboardingDescription1,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding2,
      title:  tr.onboardingTitle2,
      description:  tr.onboardingDescription2,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding3,
      title:  tr.onboardingTitle3,
      description:  tr.onboardingDescription3,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding4,
      title:  tr.onboardingTitle4,
      description:  tr.onboardingDescription4,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding5,
      title:  tr.onboardingTitle5,
      description:  tr.onboardingDescription5,
    ),
    OnboardingPageContent(
      image: Assets.images.png.onboarding6,
      title:  tr.onboardingTitle6,
      description:  tr.onboardingDescription6,
    ),
  ]);

  static int get pageCount => pages.length;
}
