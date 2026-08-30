import 'package:flutter/material.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  // App Constants for Strings to avoid hardcoding
  static const String appTitle = 'Mind Spark Dashboard';
  static const String welcomeMessage = 'Welcome to Mind Spark Elite!\nEngine Core Initialized Successfully.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Match the deep dark dashboard background canvas
      backgroundColor: const Color(0xFF0F172A), 
      appBar: AppBar(
        title: const Text(appTitle),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
      ),
      body: const Center(
        child: Text(
          welcomeMessage,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.white70,
          ),
        ),
      ),
    );
  }
}
