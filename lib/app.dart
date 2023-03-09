import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'config/app_theme.dart';
import 'features/authentication/data/datasources/auth_remote_data_source.dart';
import 'features/authentication/data/repositories/auth_repository_impl.dart';
import 'features/authentication/domain/entities/auth.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';
import 'features/home/presentasion/pages/home_main.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/splash/view/splash_page.dart';
import 'features/user/data/datasources/user_remote_data_source.dart';
import 'features/user/data/repositories/user_repository_impl.dart';
import 'features/user/domain/repositories/user_repository.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //dibuat late karena isinya baru diinisiasi kemudian di initState

  late final AuthRepository _authRepository;
  //late final UserRepository _userRepository;
  /* late final AuthRemoteDataSource _authRemoteDataSource;
  late final UserRemoteDataSource _userRemoteDataSource; */

  @override
  void initState() {
    super.initState();
    /*  _authRemoteDataSource = AuthRemoteDataSourceImpl();
    _userRemoteDataSource = UserRemoteDataSourceImpl();
    _authRepository =
        AuthRepositoryImpl(authRemoteDataSource: _authRemoteDataSource);
    _userRepository =
        UserRepositoryImpl(userRemoteDataSource: _userRemoteDataSource); */
    _authRepository = GetIt.I<AuthRepository>();
    //_userRepository = GetIt.I<UserRepository>();
  }

  @override
  void dispose() {
    _authRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => GetIt.I<AuthCubit>(),
      child: const AppView(),
    );
  }
  /* Widget build(BuildContext context) {
    return RepositoryProvider.value(
      //menggunakan RepositoryProvider agar bisa mengambil repository dengan cara
      //RepositoryProvider.of<AuthRepository>(context) di child bawahnya
      value: _authRepository,
      child: BlocProvider(
        //create: (_) => AuthenticationBloc(
        /* create: (_) => AuthCubit(
          authenticationRepository: _authRepository,
          userRepository: _userRepository,
        ), */
        create: (_) => GetIt.I<AuthCubit>(),
        child: const AppView(),
      ),
    );
  } */
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bana App',
      theme: AppTheme.light,
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        //return BlocListener<AuthenticationBloc, AuthenticationState>(
        return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) {
            print(state.status);
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  HomeMain.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}
