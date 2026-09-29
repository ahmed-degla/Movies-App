# Injectable and GetIt

Injectable annotations describe the app's dependency registrations. The
generator writes `lib/core/di/injection.config.dart`, and GetIt resolves the
registered dependencies at runtime.

## App setup

`lib/core/di/injection.dart` exposes the GetIt instance and generated
initialization:

```dart
final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies() {
  getIt.init();
}
```

The app calls `configureDependencies()` during startup after Firebase
initialization. `DioModule` registers Dio as a singleton. Retrofit service
factories use `@factoryMethod`; feature data sources and repository
implementations are registered against their abstractions. Cubits and use
cases use their existing feature annotations.

## Common registrations in this app

| Annotation | Use |
| --- | --- |
| `@injectable` | Register a factory dependency, commonly a Cubit. |
| `@singleton` | Register one eagerly created instance, used for app services and use cases. |
| `@lazySingleton` | Register one instance on first request, used by service modules and Retrofit clients. |
| `@module` | Provide external types such as Dio that cannot be annotated in this app. |
| `@Injectable(as: SomeContract)` | Register a concrete implementation for an abstraction. |
| `@factoryMethod` | Select the Retrofit-generated implementation constructor. |
| `@InjectableInit()` | Mark the app's dependency initialization function. |

Use constructor injection for dependencies. Do not manually edit
`injection.config.dart`; update the source annotations and regenerate:

```sh
dart run build_runner build
```

## References

- [App technologies](README.md)
- Dependency setup: `lib/core/di/injection.dart`
- Dio registration: `lib/core/network/dio_factory.dart`
- [Injectable documentation](https://pub.dev/packages/injectable)
- [GetIt documentation](https://pub.dev/packages/get_it)
