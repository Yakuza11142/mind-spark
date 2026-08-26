import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart'; // Add your intro screen import here
import 'screens/main_layout_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String intro = '/intro';
  static const String home = '/home';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());
      default:
        // Anti-Crash Fallback Route
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("Route Not Found. Re-routing to safety..."),
            ),
          ),
        );
    }
  }
}
