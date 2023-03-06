import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;

import '/features/authentication/domain/repositories/auth_repository.dart';
import '/features/authentication/presentation/bloc/authentication_bloc.dart';
import '../features/authentication/data/datasources/auth_remote_data_source.dart';
import '../features/authentication/data/repositories/auth_repository_impl.dart';
import '../features/authentication/domain/usecase/get_status.dart';
import '../features/authentication/domain/usecase/log_in.dart';
import '../features/login/data/datasources/login_remote_data_source sqlite.dart';
import '../features/login/data/datasources/login_remote_data_source.dart';
import '../features/login/data/repositories/login_repository_impl.dart';
import '../features/login/domain/repositories/login_repository.dart';
import '../features/login/domain/usecases/get_authentication.dart';
import '../features/login/presentation/bloc/login/login_bloc.dart';
import '../features/user/data/datasources/user_remote_data_source.dart';
import '../features/user/data/repositories/user_repository_impl.dart';
import '../features/user/domain/repositories/user_repository.dart';
import '../features/weather/data/datasources/remote_data_source.dart';
import '../features/weather/data/repositories/weather_repository_impl.dart';
import '../features/weather/domain/repositories/weather_repository.dart';
import '../features/weather/domain/usecases/get_current_weather.dart';
import '../features/weather/presentation/bloc/weather_bloc.dart';

final locator = GetIt.instance;

void init() async {
  // bloc
  locator.registerFactory<WeatherBloc>(() => WeatherBloc(locator()));
  locator
      .registerFactory<LoginBloc>(() => LoginBloc(authRepository: locator()));
  //locator.registerFactory<LoginBloc>(() => LoginBloc(locator()));
  locator.registerFactory(() => AuthenticationBloc(
      authenticationRepository: locator(), userRepository: locator()));

  locator.registerLazySingleton(() => GetCurrentWeather(locator()));
  locator.registerLazySingleton(() => GetAuthentication(locator()));
  locator.registerLazySingleton(() => GetStatus(locator()));
  locator.registerLazySingleton(() => LogIn(locator()));

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
