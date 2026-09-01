import 'package:flutter/material.dart';
import 'routes.dart';

// --- Primary Staging Screen Modules ---
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/main_layout_screen.dart';

// --- Production Core Feature Views ---
import 'screens/spark_ai_view.dart';
import 'screens/ai_video_feed_view.dart';
import 'views/home_view.dart';
import 'views/login_view.dart';
import 'views/rank_view.dart';
import 'views/legal_view.dart';
import 'views/rewards_view.dart';
import 'views/settings_view.dart';
import 'views/subjects_view.dart';

void main() async {
  // 🚀 Core framework initialization (Dependency-free & works 100% offline)
  WidgetsFlutterBinding.ensureInitialized();

  // 📡 AUTOMATIC LIGHT-FIELD ROUTING INJECTION GRID
  // Each file maps its constructor straight into the string-free router registry hub
  AppRoutes.registerRoute(AppRoutes.splash, (_) => const SplashScreen());
  AppRoutes.registerRoute(AppRoutes.intro, (_) => const IntroScreen());
  AppRoutes.registerRoute(AppRoutes.login, (_) => const LoginView());
  AppRoutes.registerRoute(AppRoutes.dashboard, (_) => const MainLayoutScreen());
  
  // Custom modules and secondary layout branches bind smoothly here
  AppRoutes.registerRoute('/home_view', (_) => const HomeView());
  AppRoutes.registerRoute('/subject_view', (_) => const SubjectsView());
  AppRoutes.registerRoute('/video_view', (_) => const AiVideoFeedView());
  AppRoutes.registerRoute('/spark_ai_view', (_) => const SparkAiView());
  AppRoutes.registerRoute('/rank_view', (_) => const RankView());
  AppRoutes.registerRoute('/settings_view', (_) => const SettingsView());
  AppRoutes.registerRoute('/rewards_view', (_) => const RewardsView());
  AppRoutes.registerRoute('/legal_view', (_) => const LegalView());

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
      initialRoute: AppRoutes.splash,
      onGenerateRoute: AppRoutes.generateRoute,
    );
  }
}
