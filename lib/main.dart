import 'package:flutter/material.dart';

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
      // ✅ FIXED: Using direct baseline string path identifiers natively
      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        final String rawPath = settings.name ?? '/';

        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            // Web & Native multi-tier routing resolution map
            if (rawPath == '/' || rawPath.contains('splash')) return const SplashScreen();
            if (rawPath.contains('intro')) return const IntroScreen();
            if (rawPath.contains('login')) return const LoginView();
            if (rawPath.contains('dashboard') || rawPath.contains('main')) return const MainLayoutScreen();
            if (rawPath.contains('home')) return const HomeView();
            if (rawPath.contains('subject')) return const SubjectsView();
            if (rawPath.contains('video')) return const AiVideoFeedView();
            if (rawPath.contains('spark')) return const SparkAiView();
            if (rawPath.contains('rank')) return const RankView();
            if (rawPath.contains('settings')) return const SettingsView();
            if (rawPath.contains('rewards')) return const RewardsView();
            if (rawPath.contains('legal')) return const LegalView();

            return const SplashScreen();
          },
        );
      },
    );
  }
}
