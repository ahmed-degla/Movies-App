# App technologies

This directory documents the technologies configured by this app. The
Retrofit and Injectable guides are split into their own files:

- [Retrofit](retrofit.md)
- [Injectable and GetIt](injectable.md)

## Application stack

| Technology | Use in this app |
| --- | --- |
| Flutter and Dart | Cross-platform UI, application logic, and the Dart package/runtime ecosystem. |
| Flutter localization and `intl` | Generated English and Arabic strings, locale-aware formatting, and localization delegates. |
| `flutter_bloc` | Cubit-based presentation state, including home, authentication, and profile flows. |
| Shared app widgets | Reusable UI includes `AppPaginatedScroll`, which loads pages from the server's page size and total count. |
| `auto_route` | Typed application routes, generated route declarations, and the authentication guard. |
| Dio | HTTP transport and shared request configuration. Retrofit clients use the app's configured Dio instance. |
| Retrofit | Typed declarations for the YTS API; see [Retrofit](retrofit.md). |
| Injectable and GetIt | Annotation-driven dependency registration and runtime dependency lookup; see [Injectable](injectable.md). |
| `json_annotation` and `json_serializable` | Typed JSON DTOs and generated serializers for API and persistence data. |
| Firebase Core | Initialize Firebase before configuring app services. |
| Firebase Authentication | Email/password and Google sign-in, account actions, and auth state. |
| Cloud Firestore | User profile, watchlist, and viewing-history persistence. |
| Google Sign-In | Google account authentication used with Firebase Authentication. |
| `connectivity_plus` | Check connectivity before requesting movie data. |
| `pretty_dio_logger` | Dio request/response logging. |
| `cached_network_image_ce` | Load and cache remote movie artwork. |
| `flutter_svg` | Render SVG artwork from the app's assets. |
| `flutter_gen` | Generate typed asset references. |
| `flutter_screenutil_plus` | Scale UI dimensions and typography throughout presentation widgets. |
| `carousel_slider` | Carousel presentation components. |
| `country_code_picker` | Country and dialing-code selection in profile/authentication forms. |
| `pin_code_fields` | PIN and verification-code input. |
| `font_awesome_flutter` | Font Awesome icon set. |
| `cupertino_icons` | Cupertino icon set. |
| `shared_preferences` | Lightweight local key/value persistence where used. |
| `flutter_native_splash` | Configure native launch-screen assets. |

## Development and generation tools

| Tool | Use |
| --- | --- |
| `build_runner` | Run code generators. |
| `retrofit_generator` | Generate Retrofit's Dio client implementation. |
| `injectable_generator` | Generate GetIt registrations from Injectable annotations. |
| `auto_route_generator` | Generate typed route classes and router implementation. |
| `json_serializable` | Generate DTO JSON converters. |
| `flutter_gen_runner` | Generate typed asset accessors. |
| `flutter_test` | Flutter unit and widget tests. |
| `flutter_lints` | Dart and Flutter static analysis rules. |

Run the project's generators with:

```sh
dart run build_runner build
```

Generated Dart files are build outputs; update their annotated source and
regenerate rather than editing generated files by hand.
