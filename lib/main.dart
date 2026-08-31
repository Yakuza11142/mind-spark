import 'package:flutter/material.dart';
import 'routes.dart';

// 🌐 Natively swaps path strategy execution based on compilation target
import 'url_strategy_stub.dart' if (dart.library.js_util) 'url_strategy_web.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Safely initializes web path cleanup natively, or bypasses quietly on mobile
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
      // Sets the global canvas background to match your custom dark purple palette
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1B1424),
      ),
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
