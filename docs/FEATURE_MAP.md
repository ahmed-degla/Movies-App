# Feature map

| Feature | Responsibility | Presentation structure |
| --- | --- | --- |
| `auth/sign_in` | Email and Google sign-in | `sign_in_screen.dart` coordinates the screen; `widgets/sign_in_credentials.dart` and `widgets/sign_in_alternatives.dart` contain the main UI sections. |
| `auth/sign_up` | Account creation and initial profile details | `sign_up_screen.dart` coordinates validation and submission; `widgets/sign_up_avatar_picker.dart` and `widgets/sign_up_form_fields.dart` contain the avatar and form sections. |
| `auth/forgot_password` | Send Firebase password-reset email | `forgot_password_screen.dart` connects the form to its cubit; the cubit delegates through the use case, repository, and datasource to `FirebaseAuthService`. |
| `home` | Browse, search, filter, and open movies; show the user's library | `home_screen.dart` hosts the home tabs. Each tab lives under `presentation/taps/`; larger UI sections live under `presentation/widgets/`. Profile overview and tab selection are separate widgets. |
| `movie_details` | Load and present movie details, cast, screenshots, similar movies, and torrents | `movie_details_screen.dart` coordinates loading, error, and loaded states; focused sections live under `presentation/widgets/`. |
| `update_profile` | Edit profile data, select an avatar, and manage account actions | `update_profile_screen.dart` coordinates form state and actions; the editor and action area are feature widgets. |
| Home profile tab | Present the signed-in user's overview, watchlist, and history | The tab is under `home/presentation/taps/profile_tap/`; its tab-specific library widgets live alongside it. |
| `onboarding` | Present introductory pages and persist completion | `onboarding_screen.dart` coordinates the page view and cubit; the page background and navigation panel are feature widgets. |
| `splash` | Initialize app startup and choose the initial route | `splash_screen.dart` coordinates startup state and routing. |

## Presentation convention

Keep screens responsible for state, validation, and navigation orchestration.
Move substantial visual regions into focused widgets under the feature's
`presentation/widgets/` directory. Pass data and callbacks explicitly, and keep
feature-specific widgets inside their owning feature unless they are genuinely
shared. Movie cards receive a `MovieEntity` and own the common movie-details
navigation behavior.
