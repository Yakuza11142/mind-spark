import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart'; // Built-in SDK package to manage web paths
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Prevents the browser from looking for physical server folders on reloads
  usePathUrlStrategy(); 

  // 🚀 Dependency-free core initialization
  runApp(const MindSparkApp());
}

class MindSparkApp extends StatelessWidget {
  const MindSparkApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Spark',
      debugShowCheckedModeBanner: false,
      // Sets a dark canvas theme globally for all scaffolds
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
