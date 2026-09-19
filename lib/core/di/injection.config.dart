// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:movies/core/network/dio_factory.dart' as _i759;
import 'package:movies/features/home/data/api_service/api_service.dart'
    as _i451;
import 'package:movies/features/home/data/datasource/movie_datasource.dart'
    as _i681;
import 'package:movies/features/home/data/datasource_impl/movie_datasource_impl.dart'
    as _i222;
import 'package:movies/features/home/data/repo_impl/movie_repo_impl.dart'
    as _i495;
import 'package:movies/features/home/domain/repo/movies_repo.dart' as _i287;
import 'package:movies/features/home/domain/use_cases/get_movies_use_case.dart'
    as _i604;
import 'package:movies/features/home/presentation/view_model/home_cubit.dart'
    as _i217;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final dioModule = _$DioModule();
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.lazySingleton<_i451.ApiService>(() => _i451.ApiService(gh<_i361.Dio>()));
    gh.factory<_i681.MovieDataSource>(
      () => _i222.MovieDataSourceImpl(gh<_i451.ApiService>()),
    );
    gh.factory<_i287.MoviesRepo>(
      () => _i495.MoviesRepoImpl(gh<_i681.MovieDataSource>()),
    );
    gh.singleton<_i604.GetMoviesUseCase>(
      () => _i604.GetMoviesUseCase(gh<_i287.MoviesRepo>()),
    );
    gh.factory<_i217.HomeCubit>(
      () => _i217.HomeCubit(gh<_i604.GetMoviesUseCase>()),
    );
    return this;
  }
}

class _$DioModule extends _i759.DioModule {}
