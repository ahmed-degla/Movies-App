import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get phoneNumber;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password ?'**
  String get forgotPassword;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @createOne.
  ///
  /// In en, this message translates to:
  /// **'Create One'**
  String get createOne;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @loginWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Login With Google'**
  String get loginWithGoogle;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @verifyEmail.
  ///
  /// In en, this message translates to:
  /// **'Verify Email'**
  String get verifyEmail;

  /// No description provided for @avatar.
  ///
  /// In en, this message translates to:
  /// **'Avatar'**
  String get avatar;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See More'**
  String get seeMore;

  /// No description provided for @movieDetailsWatch.
  ///
  /// In en, this message translates to:
  /// **'Watch'**
  String get movieDetailsWatch;

  /// No description provided for @movieDetailsScreenShots.
  ///
  /// In en, this message translates to:
  /// **'Screen Shots'**
  String get movieDetailsScreenShots;

  /// No description provided for @movieDetailsSimilar.
  ///
  /// In en, this message translates to:
  /// **'Similar'**
  String get movieDetailsSimilar;

  /// No description provided for @movieDetailsSummary.
  ///
  /// In en, this message translates to:
  /// **'Summary'**
  String get movieDetailsSummary;

  /// No description provided for @movieDetailsCast.
  ///
  /// In en, this message translates to:
  /// **'Cast'**
  String get movieDetailsCast;

  /// No description provided for @movieDetailsGenres.
  ///
  /// In en, this message translates to:
  /// **'Genres'**
  String get movieDetailsGenres;

  /// No description provided for @movieDetailsNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'N/A'**
  String get movieDetailsNotAvailable;

  /// No description provided for @movieDetailsTryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get movieDetailsTryAgain;

  /// No description provided for @movieDetailsNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name : {name}'**
  String movieDetailsNameLabel(String name);

  /// No description provided for @movieDetailsCharacterLabel.
  ///
  /// In en, this message translates to:
  /// **'Character : {character}'**
  String movieDetailsCharacterLabel(String character);

  /// No description provided for @movieDetailsNoTrailer.
  ///
  /// In en, this message translates to:
  /// **'No trailer is available for this movie.'**
  String get movieDetailsNoTrailer;

  /// No description provided for @movieDetailsTrailerOpenFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open the trailer.'**
  String get movieDetailsTrailerOpenFailed;

  /// No description provided for @movieDetailsWatchAddedToHistory.
  ///
  /// In en, this message translates to:
  /// **'Added to your watch history.'**
  String get movieDetailsWatchAddedToHistory;

  /// No description provided for @movieDetailsWatchFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t start watching this movie.'**
  String get movieDetailsWatchFailed;

  /// No description provided for @movieDetailsBookmarkFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t update your watchlist.'**
  String get movieDetailsBookmarkFailed;

  /// No description provided for @movieDetailsNoInternet.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get movieDetailsNoInternet;

  /// No description provided for @movieDetailsLoadFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load movie details.'**
  String get movieDetailsLoadFailed;

  /// No description provided for @movieDetailsSuggestionsFailed.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load similar movies.'**
  String get movieDetailsSuggestionsFailed;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
