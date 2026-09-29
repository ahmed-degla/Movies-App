import 'package:flutter_test/flutter_test.dart';
import 'package:movies/features/onboarding/presentation/onboarding_page_content.dart';
import 'package:movies/generated/l10n/app_localizations_en.dart';

void main() {
  test('every onboarding page has an image, title, and description', () {
    final localizations = AppLocalizationsEn();
    final pages = OnboardingPageContent.pages;

    expect(pages, hasLength(6));
    for (final page in pages) {
      expect(page.image.path, isNotEmpty);
      expect(page.title(localizations), isNotEmpty);
      expect(page.description(localizations), isNotEmpty);
    }
  });
}
