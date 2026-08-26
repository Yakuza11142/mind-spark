import 'package:flutter/material.dart';

class NavigationRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    return MaterialPageRoute(
      builder: (_) => const Scaffold(
        body: Center(child: Text('Navigation Fallback Route')),
      ),
    );
  }
}
