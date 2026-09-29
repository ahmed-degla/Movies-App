# Movies App Engineering Rules

## General

- Keep changes scoped to the requested behavior and preserve existing user
  changes.
- Use the repository's established Flutter, Dart, dependency-injection, and
  localization patterns.
- Prefer typed APIs and explicit error handling; do not silently swallow
  failures or use broad dynamic casts.
- Run `dart format` on changed Dart files and `flutter analyze` on the smallest
  useful scope.

## Localization

- All user-visible text must come from `AppLocalizations` generated from
  `assets/langs/app_en.arb` and `assets/langs/app_ar.arb`.
- Never add user-facing literals to widgets, validators, exceptions displayed
  to users, or state messages.
- Add matching keys and translations to both ARB files, then regenerate with
  `flutter gen-l10n`.
- Prefer `AppLocalizations.of(context)!` in presentation code. Keep data and
  domain layers independent of Flutter `BuildContext`; return typed failures or
  stable error codes instead of localized strings.

## Assets

- Use `Assets.images.png.*` and `Assets.images.svg.*` from
  `lib/generated/assets/assets.gen.dart`; do not create an `AssetsManager`
  wrapper.
- Regenerate FlutterGen output with `dart run build_runner build` when assets
  change.

## Architecture

- Keep feature code organized into `data`, `domain`, and `presentation`.
- `data` owns API/Firestore DTOs, data sources, and repository implementations.
- `domain` owns entities, repository contracts, and use cases; it must not
  depend on Flutter widgets, Firebase, Retrofit, or generated JSON DTOs.
- `presentation` owns screens, widgets, Cubits, and view state. Delegate I/O
  through use cases or injected services.
- Map data DTOs into domain entities at the data/repository boundary.
- Retrofit interfaces belong in `data/api_service`; annotate requests with
  explicit HTTP methods and query/path names.

## JSON Models

- Use `json_annotation` and `@JsonSerializable` for data models and API
  parameter DTOs. Keep generated `*.g.dart` files out of manual edits.
- Annotate API field names with `@JsonKey(name: ...)`; use typed converters for
  non-JSON types such as Firestore `Timestamp`.
- Regenerate with
  `dart run build_runner build --delete-conflicting-outputs`.

## Enums

- Define finite app choices as Dart enums instead of stringly typed values.
- Keep enum serialization and presentation labels explicit; localize labels in
  presentation code rather than coupling enums to `BuildContext`.

## Routing

- Declare routes in `lib/core/routing/app_router.dart` and navigate through
  typed AutoRoute route classes.
- Treat `app_router.gr.dart` as generated output; regenerate it with
  `dart run build_runner build --delete-conflicting-outputs`.

## Theming and Widgets

- Use the app theme extension and ScreenUtil sizing helpers for UI dimensions
  and colors; avoid hardcoded app colors and device-specific pixel sizes.
- Put genuinely shared UI in `lib/widgets`; keep feature-specific widgets with
  their feature.
- Reusable widgets should expose typed inputs and callbacks, avoid owning
  feature business logic, and receive localized text from callers.

## Dependency Injection

- Register app services through Injectable annotations and initialize them
  through `lib/core/di/injection.dart`.
- Treat `injection.config.dart` as generated output; do not hand-edit it.

## Firebase

- Keep Firebase access in core Firebase services or feature data sources, not
  widgets or domain entities.
- Scope user data by authenticated UID and validate all Firestore documents
  with deployed Security Rules.
- Keep PII owner-only. Never weaken rules to public reads/writes to work around
  a permission error.
