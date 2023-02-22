import 'package:flutter/material.dart';
import 'package:flutter_bana_app/feature/home/presentasion/pages/home_main.dart';
import 'package:flutter_bana_app/feature/login/presentation/pages/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '/feature/weather/presentation/bloc/weather_bloc.dart';
import '/feature/weather/presentation/pages/weather_page.dart';
import 'config/app_theme.dart';
import 'di/injection.dart' as di;
import 'config/routes.dart' as router;
import 'feature/login/presentation/bloc/login/login_bloc.dart';
import '/feature/balance/presentation/pages/balance_page.dart';
import 'size_config.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
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
