import 'package:flutter/material.dart';
import 'package:flutter_bana_app/config/app_route_constant.dart';
import 'package:go_router/go_router.dart';

import '../features/authentication/domain/entities/auth.dart';
import '../features/home/presentasion/pages/home_main.dart';
import '../features/login/presentation/pages/login_page.dart';
import '../features/splash/view/splash_page.dart';

class AppRoute {
  static final _rootNavigatorKey = GlobalKey<NavigatorState>();
  static final _shellNavigatorKey = GlobalKey<NavigatorState>();

  static GoRouter _returnRouter(AuthenticationStatus authStatus) {
    return GoRouter(
      initialLocation: '/splash',
      debugLogDiagnostics: true,
      navigatorKey: _rootNavigatorKey,
      routes: <RouteBase>[
        GoRoute(
          path: '/',
          name: AppRouteConstant.homeRoute,
          builder: (context, state) => const HomeMain(),
        ),
        GoRoute(
          name: AppRouteConstant.loginRoute,
          path: '/login',
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/splash',
          name: AppRouteConstant.splashRoute,
          builder: (context, state) => const SplashPage(),
        ),
      ],
      redirect: (context, state) {
        if (authStatus == AuthenticationStatus.unauthenticated) {
          return '/login';
        } else if (authStatus == AuthenticationStatus.authenticated) {
          return '/';
        }
        return null;
      },
      errorBuilder: (context, state) => const LoginPage(),
    );
  }

  /* static final GoRouter _router = GoRouter(
    initialLocation: '/splash',
    debugLogDiagnostics: true,
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          print('here is it');
          return BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              switch (state.status) {
                case AuthenticationStatus.authenticated:
                  context.goNamed(AppRouteConstant.homeRoute);
                  break;
                case AuthenticationStatus.unauthenticated:
                  context.goNamed(AppRouteConstant.loginRoute);
                  break;
                case AuthenticationStatus.unknown:
                  break;
              }
            },
            child: child,
          );
        },
        routes: <RouteBase>[
          GoRoute(
            path: '/',
            name: AppRouteConstant.homeRoute,
            builder: (context, state) => const HomeMain(),
          ),
          GoRoute(
            name: AppRouteConstant.loginRoute,
            path: '/login',
            builder: (context, state) => const LoginPage(),
          ),
          GoRoute(
            path: '/splash',
            name: AppRouteConstant.splashRoute,
            builder: (context, state) => const SplashPage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) => const LoginPage(),
  );
  static GoRouter get router => _router; */

  static GoRouter getRouter(AuthenticationStatus authStatus) {
    return _returnRouter(authStatus);
  }
}
