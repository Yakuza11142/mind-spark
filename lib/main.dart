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
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1B1424),
      ),
      // Automatically triggers standard browser location path routing loops
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
