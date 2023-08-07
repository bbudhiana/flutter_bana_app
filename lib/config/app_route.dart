import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/domain/entities/auth.dart';
import '../features/home/presentasion/pages/home_main.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../features/splash/view/splash_page.dart';

class AppRoute {
  static GoRouter getRoutes(AuthenticationStatus isAuth) {
    return GoRouter(
      initialLocation: '/splash',
      redirect: (BuildContext context, GoRouterState state) {
        if (isAuth == AuthenticationStatus.unauthenticated) {
          return '/login';
        } else if (isAuth == AuthenticationStatus.authenticated) {
          return '/';
        } else {
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
