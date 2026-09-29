# Retrofit and Dio

Retrofit declares typed HTTP endpoints; Dio performs the requests. The app's
Dio configuration is provided by `lib/core/network/dio_factory.dart`. The
home API is declared in
`lib/features/home/data/api_service/api_service.dart` and its generated client
is `api_service.g.dart`.

## Add or update an endpoint

1. Declare the endpoint in the feature's `data/api_service` interface.
2. Add an explicit HTTP annotation and named path/query parameters.
3. Return a typed response DTO when the response has a model; keep response
   mapping inside the data layer.
4. Regenerate the client and run the relevant analysis/tests.

```dart
@GET('list_movies.json')
Future<MoviesResponseModel> getMovies({
  @Query('page') int? page,
  @Query('limit') int? limit,
});
```

Movie requests pass pagination and filters as named query arguments. The API
response DTO (`MoviesResponseModel`) keeps `@meta` out of the serialized model;
`MoviesDataModel` carries the count, limit, page number, and movie list.

Generated client implementations are not manually edited. Run:

```sh
dart run build_runner build
```

## Request logging and errors

`DioModule` configures the API base URL and JSON headers, and adds
`PrettyDioLogger`. Keep credentials and other secrets out of request logs.
Data sources return the app's typed `ApiResult` instead of exposing Dio to
presentation widgets or domain code.

## References

- [App technologies](README.md)
- Retrofit API: `lib/features/home/data/api_service/api_service.dart`
- Dio module: `lib/core/network/dio_factory.dart`
- [Retrofit documentation](https://pub.dev/packages/retrofit)
- [Dio documentation](https://pub.dev/packages/dio)
