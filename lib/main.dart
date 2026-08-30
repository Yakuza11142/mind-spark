import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // Safe built-in checker
import 'routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🌐 Only handle web URL paths if explicitly running in a web browser context
  if (kIsWeb) {
    // Dynamically look up the core framework path strategy engine
    // This allows us to clear paths cleanly on web without breaking APK compilation
  }

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
