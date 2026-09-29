---
name: movies-app-conventions
description: Apply this repository's Flutter architecture, localization, assets, JSON model, routing, DI, theming, Firebase, enum, and reusable widget conventions.
---

# Movies App Conventions

Read `.agents/rules.md` before implementing repository changes. These
repository-specific requirements supplement the tool's general coding rules.

## Localization

Use generated `AppLocalizations` from the English and Arabic ARB resources for
every user-visible string. Add the same key to both
`assets/langs/app_en.arb` and `assets/langs/app_ar.arb`, then run
`flutter gen-l10n`. Presentation widgets obtain translations from their
`BuildContext`; data/domain layers must not depend on context or localized
strings.

## Assets

Import `package:movies/generated/assets/assets.gen.dart` and reference assets
directly, such as `Assets.images.png.logo.image()` or
`Assets.images.svg.backArrow.svg()`. Do not introduce or retain a hand-written
asset manager.

## Clean Architecture and Retrofit

Keep each feature split into `data`, `domain`, and `presentation`. Put Retrofit
interfaces, generated API clients, DTOs, data sources, and repository
implementations under `data`; keep entities, repository contracts, and use
cases in `domain`; put screens, widgets, Cubits, and states in `presentation`.
Map DTOs into entities at the data boundary. Keep network and Firebase
dependencies out of domain and presentation widgets.

Declare Retrofit endpoints with explicit HTTP annotations and named query/path
parameters. Generated `.g.dart` files are build outputs, not hand-maintained
code.

## JSON Serialization

Use `json_annotation` and `@JsonSerializable` for API and persistence models.
Name wire fields with `@JsonKey`, use explicit converters for special types,
and generate serializers using:

```sh
dart run build_runner build --delete-conflicting-outputs
```

Do not manually edit generated serializers.

## Enums

Use enums for finite state and choice sets. Keep labels localized in the
presentation layer and keep enums free of `BuildContext` dependencies. Map
external string values to enums explicitly and handle unknown values safely.

## Routing

Declare screens in `lib/core/routing/app_router.dart` and navigate with typed
generated AutoRoute classes. Regenerate route code with build_runner; do not
hand-edit `app_router.gr.dart`.

## Theming and Reusable Widgets

Use the project's `AppThemeExtension` and ScreenUtil helpers. Shared,
domain-neutral UI belongs in `lib/widgets`; feature-only UI stays under its
feature. Reusable widgets accept typed values, callbacks, and localized labels
as inputs and do not reach into repositories or Firebase services.

## Dependency Injection

Annotate services and feature components with Injectable and register through
the existing `getIt` setup. Regenerate `injection.config.dart` rather than
editing it manually.

## Firebase

Keep Firebase calls in injected services or data sources. Use the current
authenticated user's UID to scope profile and nested movie data. Keep PII
owner-only and preserve the default-deny posture of Firestore rules.
