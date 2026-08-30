import 'package:flutter/material.dart';

class MainLayoutScreen extends StatelessWidget {
  const MainLayoutScreen({super.key});

  // Centralized strings to prevent hardcoded values
  static const String appTitle = 'Mind Spark';
  static const String welcomeMessage = 'Welcome to Mind Spark!\nEngine Core Initialized Successfully.';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appTitle,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
          ),
        ),
        backgroundColor: const Color(0xFF1E293B),
        elevation: 0,
        centerTitle: false,
        // Optional: Safe back-button handling if transitioning from intro
        automaticallyImplyLeading: false, 
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24.0),
          child: Text(
            welcomeMessage,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.white70,
              height: 1.5, // Improves multiline readability
            ),
          ),
        ),
      ),
    );
  }
}
