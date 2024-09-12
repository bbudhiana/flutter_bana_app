import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'config/app_theme.dart';
import 'features/authentication/domain/entities/auth.dart';
import 'features/authentication/domain/repositories/auth_repository.dart';
import 'features/authentication/presentation/bloc/authentication_bloc.dart';
import 'features/authentication/presentation/cubit/auth_cubit.dart';
import 'features/home/presentasion/pages/home_main.dart';
import 'features/language/presentation/bloc/language_bloc.dart';
import 'features/login/presentation/pages/login_page.dart';
import 'features/splash/view/splash_page.dart';

class App extends StatefulWidget {
  const App({super.key});

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          //create: (_) => GetIt.I<AuthCubit>(),
          create: (_) => GetIt.I<AuthenticationBloc>(),
        ),
        // BlocProvider(
        //   create: (_) => GetIt.I<AuthCubit>(),
        // ),
        BlocProvider(
          create: (context) => GetIt.I<LanguageBloc>(),
        ),
      ],
      child: const _AppView(),
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

class _AppView extends StatefulWidget {
  const _AppView();

  @override
  State<_AppView> createState() => _AppViewState();
}

class _AppViewState extends State<_AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {
    //final l10n = AppLocalizations.of(context)!;
    //provider LanguageBloc sudah di set di parent, maka bisa trigger awal dulu Language nya
    context.read<LanguageBloc>().add(GetLanguage());
    return BlocBuilder<LanguageBloc, LanguageState>(
      builder: (context, state) {
        return MaterialApp(
          //return MaterialApp.router(
          //routeInformationParser: AppRoute.router.routeInformationParser,
          //routerDelegate: AppRoute.router.routerDelegate,
          //routerConfig: AppRoute.router,
          debugShowCheckedModeBanner: false,
          title: 'Bana App',
          theme: AppTheme.light,
          navigatorKey: _navigatorKey,
          locale: state.selectedLanguage.value,
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          builder: (context, child) {
            return BlocListener<AuthenticationBloc, AuthenticationState>(
              //return BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                print(state.status);
                switch (state.status) {
                  case AuthenticationStatus.authenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      HomeMain.route(),
                      (route) => false,
                    );
                    //context.go('/');
                    break;
                  case AuthenticationStatus.unauthenticated:
                    _navigator.pushAndRemoveUntil<void>(
                      LoginPage.route(),
                      (route) => false,
                    );
                    //context.goNamed('login');
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
        /* Locale langNow = state.selectedLanguage.value;
        return BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) => MaterialApp.router(
            routerConfig: AppRoute.getRouter(state.status),
            debugShowCheckedModeBanner: false,
            title: 'Bana App',
            theme: AppTheme.light,
            locale: langNow,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ); */
        /* return BlocListener<AuthCubit, AuthState>(
          listener: (context, state) => MaterialApp.router(
            routerConfig: AppRoute.getRouter(state.status),
            debugShowCheckedModeBanner: false,
            title: 'Bana App',
            theme: AppTheme.light,
            locale: langNow,
            supportedLocales: AppLocalizations.supportedLocales,
            localizationsDelegates: AppLocalizations.localizationsDelegates,
          ),
        ); */
      },
    );
  }
}
