import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:proshore_weather_app/view/home_page.dart';
import 'package:proshore_weather_app/view/welcome_page.dart';

class AppRouteName {
  static const String home = 'HomePage';
  static const String splash = 'SplashPage';
}

class AppRouter {
  late GoRouter router;

  AppRouter() {
    this.router = GoRouter(
      debugLogDiagnostics: true,
      routes: [
        GoRoute(
          path: '/',
          name: AppRouteName.splash,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: WelcomePage(),
            );
          },
        ),
        GoRoute(
          path: '/home',
          name: AppRouteName.home,
          builder: (context, state) {
            return const HomePage();
          },
        ),
      ],
    );
  }
}
