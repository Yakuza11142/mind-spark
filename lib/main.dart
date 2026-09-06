import 'package:flutter/material.dart';
import 'generated_router.dart';
import 'repositories/app_repository.dart';

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
      onGenerateRoute: AutomatedRouter.resolveRoutes,
    );
  }
}
