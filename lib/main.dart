import 'package:flutter/material.dart';
import 'routes.dart';

// 🚀 Natively swaps files depending on target platform during compilation
import 'url_strategy_stub.dart' if (dart.library.js_util) 'url_strategy_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Safely initializes web paths natively, or bypasses quietly on mobile
  configureUrlStrategy();

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
        scaffoldBackgroundColor: const Color(0xFF0F172A),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
