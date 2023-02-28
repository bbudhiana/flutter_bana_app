import 'package:flutter_bana_app/feature/authentication/domain/repositories/auth_repository.dart';
import 'package:flutter_bana_app/feature/authentication/presentation/bloc/authentication_bloc.dart';

import '../feature/authentication/data/datasources/auth_remote_data_source.dart';
import '../feature/authentication/data/repositories/auth_repository_impl.dart';
import '../feature/authentication/domain/usecase/get_status.dart';
import '../feature/login/data/datasources/login_remote_data_source sqlite.dart';
import '../feature/login/data/datasources/login_remote_data_source.dart';
import '../feature/login/data/repositories/login_repository_impl.dart';
import '../feature/login/domain/repositories/login_repository.dart';
import '../feature/login/domain/usecases/get_authentication.dart';
import '../feature/login/presentation/bloc/login/login_bloc.dart';
import '../feature/user/data/datasources/user_remote_data_source.dart';
import '../feature/user/data/repositories/user_repository_impl.dart';
import '../feature/user/domain/repositories/user_repository.dart';
import '../feature/weather/data/datasources/remote_data_source.dart';
import '../feature/weather/data/repositories/weather_repository_impl.dart';
import '../feature/weather/domain/repositories/weather_repository.dart';
import '../feature/weather/domain/usecases/get_current_weather.dart';

import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../feature/weather/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void init() async {
  // bloc
  locator.registerFactory<WeatherBloc>(() => WeatherBloc(locator()));
  locator.registerFactory(() => LoginBloc(locator()));
  locator.registerFactory(() => AuthenticationBloc(
      authenticationRepository: locator(), userRepository: locator()));

  locator.registerLazySingleton(() => GetCurrentWeather(locator()));
  locator.registerLazySingleton(() => GetAuthentication(locator()));
  locator.registerLazySingleton(() => GetStatus(locator()));

  locator.registerLazySingleton<WeatherRepository>(
    () => WeatherRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<LoginRepository>(
    () => LoginRepositoryImpl(
      remoteDataSource: locator(),
    ),
  );

  locator.registerLazySingleton<RemoteDataSource>(
    () => RemoteDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<LoginRemoteDataSource>(
    () => LoginRemoteDataSourceImpl(
      client: locator(),
    ),
  );

  locator.registerLazySingleton<LoginRemoteDataSourceSqlite>(
    () => LoginRemoteDataSourceSqliteImpl(),
  );

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(authRemoteDataSource: locator()),
  );

  locator.registerLazySingleton<AuthRemoteDataSource>(
    () => AuthRemoteDataSourceImpl(),
  );

  locator.registerLazySingleton<UserRepository>(
    () => UserRepositoryImpl(userRemoteDataSource: locator()),
  );

  locator.registerLazySingleton<UserRemoteDataSource>(
    () => UserRemoteDataSourceImpl(),
  );

  locator.registerLazySingleton(() => http.Client());
}
