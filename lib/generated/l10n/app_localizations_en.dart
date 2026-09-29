// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get name => 'Name';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get phoneNumber => 'Phone number';

  @override
  String get login => 'Login';

  @override
  String get forgotPassword => 'Forgot Password ?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get createOne => 'Create One';

  @override
  String get or => 'OR';

  @override
  String get loginWithGoogle => 'Login With Google';

  @override
  String get createAccount => 'Create Account';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get register => 'Register';

  @override
  String get verifyEmail => 'Verify Email';

  @override
  String get avatar => 'Avatar';

  @override
  String get action => 'Action';

  @override
  String get seeMore => 'See More';

  @override
  String get movieDetailsWatch => 'Watch';

  @override
  String get movieDetailsScreenShots => 'Screen Shots';

  @override
  String get movieDetailsSimilar => 'Similar';

  @override
  String get movieDetailsSummary => 'Summary';

  @override
  String get movieDetailsCast => 'Cast';

  @override
  String get movieDetailsGenres => 'Genres';

  @override
  String get movieDetailsNotAvailable => 'N/A';

  @override
  String get movieDetailsTryAgain => 'Try Again';

  @override
  String movieDetailsNameLabel(String name) {
    return 'Name : $name';
  }

  @override
  String movieDetailsCharacterLabel(String character) {
    return 'Character : $character';
  }

  @override
  String get movieDetailsNoTrailer => 'No trailer is available for this movie.';

  @override
  String get movieDetailsTrailerOpenFailed => 'Couldn\'t open the trailer.';

  @override
  String get movieDetailsWatchAddedToHistory => 'Added to your watch history.';

  @override
  String get movieDetailsWatchFailed => 'Couldn\'t start watching this movie.';

  @override
  String get movieDetailsBookmarkFailed => 'Couldn\'t update your watchlist.';

  @override
  String get movieDetailsNoInternet => 'No internet connection';

  @override
  String get movieDetailsLoadFailed => 'Couldn\'t load movie details.';

  @override
  String get movieDetailsSuggestionsFailed => 'Couldn\'t load similar movies.';
}
