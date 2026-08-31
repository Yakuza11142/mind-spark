import 'package:flutter/material.dart';

// 🎨 Screen Frame Modules
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/main_layout_screen.dart';

// 🚀 Sub-Screen and Navigation Flow Views
import 'screens/spark_ai_view.dart';
import 'screens/ai_video_feed_view.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/rank_view.dart';
import '../views/legal_view.dart';
import '../views/rewards_view.dart';
import '../views/settings_view.dart';
import '../views/subjects_view.dart';

class AppRoutes {
  // --- Static Route Identifier Strings ---
  static const String splash = '/';
  static const String intro = '/intro';
  static const String login = '/login';
  static const String dashboard = '/dashboard';
  
  // --- Nested Sub-View Navigation Paths ---
  static const String homeView = '/home_view';
  static const String subjectView = '/subject_view';
  static const String videoView = '/video_view';
  static const String sparkAiView = '/spark_ai_view';
  static const String rankView = '/rank_view';
  static const String settingsView = '/settings_view';
  static const String rewardsView = '/rewards_view';
  static const String legalView = '/legal_view';

  /// ⚙️ Core Generation Routine linking every view path to its class compiler
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      // 1. Initial Launch Sequences
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case intro:
        return MaterialPageRoute(builder: (_) => const IntroScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginView());
        
      // 2. Main Persistent Architecture Window Anchor
      case dashboard:
        return MaterialPageRoute(builder: (_) => const MainLayoutScreen());

      // 3. Isolated Independent Sub-View Routes (For absolute global accessibility)
      case homeView:
        return MaterialPageRoute(builder: (_) => const HomeView());
      case subjectView:
        return MaterialPageRoute(builder: (_) => const SubjectsView());
      case videoView:
        return MaterialPageRoute(builder: (_) => const AiVideoFeedView());
      case sparkAiView:
        return MaterialPageRoute(builder: (_) => const SparkAiView());
      case rankView:
        return MaterialPageRoute(builder: (_) => const RankView());
      case settingsView:
        return MaterialPageRoute(builder: (_) => const SettingsView());
      case rewardsView:
        return MaterialPageRoute(builder: (_) => const RewardsView());
      case legalView:
        return MaterialPageRoute(builder: (_) => const LegalView());

      // 🚨 Security Fallback Anti-Crash Route
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            backgroundColor: Color(0xFF1B1424),
            body: Center(
              child: Text(
                "Requested View Asset Context Not Found.\nRe-routing to safety matrix...",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
            ),
          ),
        );
    }
  }
}
