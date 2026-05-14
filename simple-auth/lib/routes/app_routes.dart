import 'package:flutter/material.dart';
import '../screens/home_page.dart';
import '../screens/sign_in_page.dart';
import '../screens/sign_up_page.dart';

/// Application route names
class AppRoutes {
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  static const String home = '/home';
}

/// Application route configuration
class AppRouter {
  static Map<String, WidgetBuilder> getRoutes() {
    return {
      AppRoutes.signIn: (context) => const SignInPage(),
      AppRoutes.signUp: (context) => const SignUpPage(),
      AppRoutes.home: (context) => const HomePage(),
    };
  }

  static String getInitialRoute() => AppRoutes.signIn;
}
