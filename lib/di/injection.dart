import 'package:flutter_bana_app/feature/login/domain/usecases/get_authenticated.dart';
import 'package:flutter_bana_app/feature/login/presentation/bloc/authenticated/bloc/authenticated_bloc.dart';

import '../feature/login/data/datasources/authenticated_remote_data_source.dart';
import '../feature/login/data/datasources/login_remote_data_source.dart';
import '../feature/login/data/repositories/authenticated_repository_impl.dart';
import '../feature/login/data/repositories/login_repository_impl.dart';
import '../feature/login/domain/repositories/authenticated_repository.dart';
import '../feature/login/domain/repositories/login_repository.dart';
import '../feature/login/domain/usecases/get_authentication.dart';
import '../feature/login/presentation/bloc/login/login_bloc.dart';
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
  locator.registerFactory(() => AuthenticatedBloc(locator()));

  locator.registerLazySingleton(() => GetCurrentWeather(locator()));
  locator.registerLazySingleton(() => GetAuthentication(locator()));
  locator.registerLazySingleton(() => GetAuthenticated(locator()));

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

  locator.registerLazySingleton<AuthenticatedRepository>(
    () => AuthenticatedRepositoryImpl(
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

  locator.registerLazySingleton<AuthenticatedRemoteDataSource>(
    () => AuthenticatedRemoteDataSourceImpl(),
  );

  locator.registerLazySingleton(() => http.Client());
}
