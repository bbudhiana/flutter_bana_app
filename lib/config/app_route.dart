import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/domain/entities/auth.dart';
import '../features/authentication/presentation/cubit/auth_cubit.dart';
import '../features/home/presentasion/pages/home_main.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../features/splash/view/splash_page.dart';

class AppRoute {
  static GoRouter get routes {
    return GoRouter(
      initialLocation: '/splash',
      redirect: (BuildContext context, GoRouterState state) {
        bool statusAkhir = false;
        BlocListener<AuthCubit, AuthState>(listener: (context, state) {
          print('masuk');
          statusAkhir = state.status == AuthenticationStatus.unauthenticated ? true : false;
        });
        if (statusAkhir) {
          return '/login';
        } else {
          print(statusAkhir);
          return null;
        }
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeMain(),
        ),
        GoRoute(
          name: 'login',
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/splash',
          builder: (context, state) => const SplashPage(),
        ),
      ],
      debugLogDiagnostics: true,
    );
  }
}
