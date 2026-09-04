import 'package:flutter/material.dart';
import 'mind_spark_registry.dart'; // ✅ THE SAFE MIDDLEMAN CONNECTOR

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
      // Safely hands off navigation to your automated routing script
      onGenerateRoute: MindSparkRegistry.resolveWebAndNativeRoutes,
    );
  }
}
