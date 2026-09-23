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
import 'package:movies/core/firebase_service/firebase_auth_service.dart'
    as _i348;
import 'package:movies/core/general_cubit/general_cubit.dart' as _i187;
import 'package:movies/core/network/dio_factory.dart' as _i759;
import 'package:movies/features/auth/forgot_password/data/datasource/forgot_password_datasource.dart'
    as _i413;
import 'package:movies/features/auth/forgot_password/data/datasource_impl/forgot_password_datasource_impl.dart'
    as _i799;
import 'package:movies/features/auth/forgot_password/data/repo_impl/forgot_password_repo_impl.dart'
    as _i538;
import 'package:movies/features/auth/forgot_password/domain/repo/forgot_password_repo.dart'
    as _i76;
import 'package:movies/features/auth/forgot_password/domain/use_cases/forgot_password_use_case.dart'
    as _i514;
import 'package:movies/features/auth/forgot_password/presentation/view_model/forgot_password_cubit.dart'
    as _i32;
import 'package:movies/features/auth/sign_in/data/datasource/sign_in_datasource.dart'
    as _i622;
import 'package:movies/features/auth/sign_in/data/datasource_impl/sign_in_datasource_impl.dart'
    as _i870;
import 'package:movies/features/auth/sign_in/data/repo_impl/sign_in_repo_impl.dart'
    as _i628;
import 'package:movies/features/auth/sign_in/domain/repo/sign_in_repo.dart'
    as _i947;
import 'package:movies/features/auth/sign_in/domain/use_cases/sign_in_with_email_use_case.dart'
    as _i966;
import 'package:movies/features/auth/sign_in/domain/use_cases/sign_in_with_google_use_case.dart'
    as _i992;
import 'package:movies/features/auth/sign_in/presentation/view_model/sign_in_cubit.dart'
    as _i34;
import 'package:movies/features/auth/sign_up/data/datasource/sign_up_datasource.dart'
    as _i271;
import 'package:movies/features/auth/sign_up/data/datasource_impl/sign_up_datasource_impl.dart'
    as _i186;
import 'package:movies/features/auth/sign_up/data/repo_impl/sign_up_repo_impl.dart'
    as _i241;
import 'package:movies/features/auth/sign_up/domain/repo/sign_up_repo.dart'
    as _i692;
import 'package:movies/features/auth/sign_up/domain/use_cases/sign_up_with_email_use_case.dart'
    as _i783;
import 'package:movies/features/auth/sign_up/presentation/view_model/sign_up_cubit.dart'
    as _i10;
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
    gh.singleton<_i348.FirebaseAuthService>(() => _i348.FirebaseAuthService());
    gh.singleton<_i187.GeneralCubit>(() => _i187.GeneralCubit());
    gh.singleton<_i361.Dio>(() => dioModule.dio);
    gh.factory<_i622.SignInDataSource>(() => _i870.SignInDataSourceImpl());
    gh.lazySingleton<_i451.ApiService>(() => _i451.ApiService(gh<_i361.Dio>()));
    gh.factory<_i947.SignInRepo>(
      () => _i628.SignInRepoImpl(gh<_i622.SignInDataSource>()),
    );
    gh.factory<_i681.MovieDataSource>(
      () => _i222.MovieDataSourceImpl(gh<_i451.ApiService>()),
    );
    gh.factory<_i271.SignUpDataSource>(() => _i186.SignUpDataSourceImpl());
    gh.factory<_i413.ForgotPasswordDataSource>(
      () => _i799.ForgotPasswordDataSourceImpl(),
    );
    gh.factory<_i287.MoviesRepo>(
      () => _i495.MoviesRepoImpl(gh<_i681.MovieDataSource>()),
    );
    gh.singleton<_i966.SignInWithEmailUseCase>(
      () => _i966.SignInWithEmailUseCase(gh<_i947.SignInRepo>()),
    );
    gh.singleton<_i992.SignInWithGoogleUseCase>(
      () => _i992.SignInWithGoogleUseCase(gh<_i947.SignInRepo>()),
    );
    gh.factory<_i692.SignUpRepo>(
      () => _i241.SignUpRepoImpl(gh<_i271.SignUpDataSource>()),
    );
    gh.factory<_i76.ForgotPasswordRepo>(
      () => _i538.ForgotPasswordRepoImpl(gh<_i413.ForgotPasswordDataSource>()),
    );
    gh.singleton<_i514.ForgotPasswordUseCase>(
      () => _i514.ForgotPasswordUseCase(gh<_i76.ForgotPasswordRepo>()),
    );
    gh.factory<_i34.SignInCubit>(
      () => _i34.SignInCubit(
        gh<_i966.SignInWithEmailUseCase>(),
        gh<_i992.SignInWithGoogleUseCase>(),
      ),
    );
    gh.factory<_i32.ForgotPasswordCubit>(
      () => _i32.ForgotPasswordCubit(gh<_i514.ForgotPasswordUseCase>()),
    );
    gh.singleton<_i783.SignUpWithEmailUseCase>(
      () => _i783.SignUpWithEmailUseCase(gh<_i692.SignUpRepo>()),
    );
    gh.factory<_i10.SignUpCubit>(
      () => _i10.SignUpCubit(gh<_i783.SignUpWithEmailUseCase>()),
    );
    gh.singleton<_i604.GetMoviesUseCase>(
      () => _i604.GetMoviesUseCase(gh<_i287.MoviesRepo>()),
    );
    gh.factory<_i217.HomeCubit>(
      () => _i217.HomeCubit(
        gh<_i604.GetMoviesUseCase>(),
        gh<_i348.FirebaseAuthService>(),
      ),
    );
    return this;
  }
}

class _$DioModule extends _i759.DioModule {}
