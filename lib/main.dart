import 'package:flutter/material.dart';
import 'main.reflectable.dart'; // ✅ THE AUTOMATIC MIDDLEMAN CONNECTOR

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MindSparkApp());
}

class MindSparkApp extends StatelessWidget {
  const MindSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Spark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1B1424),
      ),
      initialRoute: '/',
      // Automatically hands off the navigation strings to the cloud-compiled mapping table
      onGenerateRoute: MindSparkRegistry.resolveWebAndNativeRoutes,
    );
  }
}
