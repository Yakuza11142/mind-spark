import 'package:flutter/material.dart';
import 'routes.dart';

void main() async {
  // 🚀 Core framework initialization (Dependency-free & works 100% offline)
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
      // Sets the deep dark dashboard theme background canvas globally
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1B1424),
      ),
      // ✅ FIXED: Pass standard root string identifier here for baseline boot
      initialRoute: '/', 
      onGenerateRoute: (RouteSettings settings) {
        // If it's the absolute first boot, wrap the Splash token type natively
        if (settings.name == '/') {
          return AppRoutes.generateRoute(
            const RouteSettings(arguments: AppRoutes.splash),
          );
        }
        return AppRoutes.generateRoute(settings);
      },
    );
  }
}
