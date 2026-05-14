// How to run:
// 1. Ensure Flutter SDK is installed (3.x or later)
// 2. Run: flutter pub get
// 3. Run: flutter run
// 4. The app will start on SignInPage

import 'package:flutter/material.dart';
import 'routes/app_routes.dart';

void main() {
  runApp(const AuthApp());
}

/// Main application widget
class AuthApp extends StatelessWidget {
  const AuthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Auth App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      initialRoute: AppRouter.getInitialRoute(),
      routes: AppRouter.getRoutes(),
    );
  }
}
