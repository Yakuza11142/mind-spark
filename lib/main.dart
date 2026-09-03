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

  static const String pathSplash = String.fromEnvironment('PATH_SPLASH', defaultValue: '/');
  static const String pathIntro = String.fromEnvironment('PATH_INTRO', defaultValue: '/intro');
  static const String pathLogin = String.fromEnvironment('PATH_LOGIN', defaultValue: '/login');
  static const String pathDashboard = String.fromEnvironment('PATH_DASHBOARD', defaultValue: '/dashboard');
  static const String pathHome = String.fromEnvironment('PATH_HOME', defaultValue: '/home_view');
  static const String pathSubject = String.fromEnvironment('PATH_SUBJECT', defaultValue: '/subject_view');
  static const String pathVideo = String.fromEnvironment('PATH_VIDEO', defaultValue: '/video_view');
  static const String pathSpark = String.fromEnvironment('PATH_SPARK', defaultValue: '/spark_ai_view');
  static const String pathRank = String.fromEnvironment('PATH_RANK', defaultValue: '/rank_view');
  static const String pathSettings = String.fromEnvironment('PATH_SETTINGS', defaultValue: '/settings_view');
  static const String pathRewards = String.fromEnvironment('PATH_REWARDS', defaultValue: '/rewards_view');
  static const String pathLegal = String.fromEnvironment('PATH_LEGAL', defaultValue: '/legal_view');

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mind Spark',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF1B1424),
      ),
      initialRoute: pathSplash,
      onGenerateRoute: (RouteSettings settings) {
        final String rawPath = settings.name ?? pathSplash;

        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            if (rawPath == pathSplash || rawPath.contains('splash')) return const SplashScreen();
            if (rawPath.contains(pathIntro) || rawPath.contains('intro')) return const IntroScreen();
            if (rawPath.contains(pathLogin) || rawPath.contains('login')) return const LoginView();
            if (rawPath.contains(pathDashboard) || rawPath.contains('dashboard') || rawPath.contains('main')) return const MainLayoutScreen();
            if (rawPath.contains(pathHome) || rawPath.contains('home')) return const HomeView();
            if (rawPath.contains(pathSubject) || rawPath.contains('subject')) return const SubjectsView();
            
            // ✅ FIXED: Removed 'const' instantiation parameters to resolve Gradle compiler traps
            if (rawPath.contains(pathVideo) || rawPath.contains('video')) return const AiVideoFeedView();
            if (rawPath.contains(pathSpark) || rawPath.contains('spark')) return const SparkAiView();
            
            if (rawPath.contains(pathRank) || rawPath.contains('rank')) return const RankView();
            if (rawPath.contains(pathSettings) || rawPath.contains('settings')) return const SettingsView();
            if (rawPath.contains(pathRewards) || rawPath.contains('rewards')) return const RewardsView();
            if (rawPath.contains(pathLegal) || rawPath.contains('legal')) return const LegalView();

            return const SplashScreen();
          },
        );
      },
    );
  }
}
