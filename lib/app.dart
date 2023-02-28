import 'package:flutter/material.dart';
import 'package:flutter_bana_app/feature/authentication/domain/usecase/get_auth_repository.dart';
import 'package:flutter_bana_app/feature/home/presentasion/pages/home_main.dart';
import 'package:flutter_bana_app/feature/login/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feature/weather/presentation/bloc/weather_bloc.dart';
import '/feature/weather/presentation/pages/weather_page.dart';
import 'config/app_theme.dart';
import 'di/injection.dart' as di;
import 'config/routes.dart' as router;
import 'feature/authentication/domain/entities/auth.dart';
import 'feature/authentication/domain/repositories/auth_repository.dart';
import 'feature/authentication/presentation/bloc/authentication_bloc.dart';
import 'feature/login/presentation/bloc/login/login_bloc.dart';
import '/feature/balance/presentation/pages/balance_page.dart';
import 'feature/splash/view/splash_page.dart';
import 'feature/user/domain/repositories/user_repository.dart';
import 'size_config.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //dibuat late karena isinya baru diinisiasi kemudian di initState
  late final AuthRepository _authRepository;
  late final UserRepository _userRepository;

  late final GetAuthRepository _getAuthRepository;

  @override
  void initState() {
    super.initState();
    _authRepository = _getAuthRepository.executeAuthRepo();
    _userRepository = _getAuthRepository.executeUserRepo();
  }

  @override
  void dispose() {
    _authRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authRepository,
          userRepository: _userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
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
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
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
