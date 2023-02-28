import 'package:flutter/material.dart';
import 'package:flutter_bana_app/feature/home/presentasion/pages/home_main.dart';
import 'package:flutter_bana_app/feature/login/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feature/weather/presentation/bloc/weather_bloc.dart';
import '/feature/weather/presentation/pages/weather_page.dart';
import 'config/app_theme.dart';
import 'di/injection.dart' as di;
import 'config/routes.dart' as router;
import 'feature/authentication/domain/repositories/auth_repository.dart';
import 'feature/login/presentation/bloc/login/login_bloc.dart';
import '/feature/balance/presentation/pages/balance_page.dart';
import 'feature/user/domain/repositories/user_repository.dart';
import 'size_config.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  //dibuat late karena isinya baru diinisiasi kemudian di initState
  late final AuthRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<WeatherBloc>()),
        BlocProvider(create: (_) => di.locator<LoginBloc>()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bana App',
        theme: AppTheme.light,
        //initialRoute: WeatherPage.route,
        onGenerateRoute: router.generateRoute,
        home: const WeatherPage(),
        //home: const HomeMain(),
        //home: const LoginPage(),
      ),
    );
  }
}
