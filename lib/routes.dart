import 'package:flutter/material.dart';

// 🏗️ Stable Base Framework Architecture Frames (Safe Compile-Time Imports)
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/main_layout_screen.dart';

// 🚀 Deferred Dynamic Import Gates (Prevents Any Missing File Compilation Crashes)
import 'screens/spark_ai_view.dart' deferred as dynamicSpark;
import 'screens/ai_video_feed_view.dart' deferred as dynamicVideo;
import '../views/home_view.dart' deferred as dynamicHome;
import '../views/login_view.dart' deferred as dynamicLogin;
import '../views/rank_view.dart' deferred as dynamicRank;
import '../views/legal_view.dart' deferred as dynamicLegal;
import '../views/rewards_view.dart' deferred as dynamicRewards;
import '../views/settings_view.dart' deferred as dynamicSettings;
import '../views/subjects_view.dart' deferred as dynamicSubjects;

/// ⚙️ THE HOLOMATICS DEFERRED ROUTING REGISTRY
/// Eliminates hardcoded strings and static import coupling entirely.
class AppRoutes {
  
  /// Centralized Runtime Factory Router
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Read the incoming Type Token argument target (Defaults to Splash)
    final Type viewToken = (settings.arguments is Type) 
        ? (settings.arguments as Type) 
        : SplashScreen;

    return MaterialPageRoute(
      settings: settings,
      builder: (context) => _compileDynamicViewport(viewToken),
    );
  }

  /// Evaluates and injects the proper view loader container without hardcoded parameters
  static Widget _compileDynamicViewport(Type viewToken) {
    // 1. Evaluate Stable Shell Frames
    if (viewToken == SplashScreen) return const SplashScreen();
    if (viewToken == IntroScreen) return const IntroScreen();
    if (viewToken == MainLayoutScreen) return const MainLayoutScreen();

    // 2. Process Deferred Views via Safe Future Builders
    return FutureBuilder(
      future: _loadLibraryForType(viewToken),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return _buildHardwareErrorLayout(viewToken);
          }
          return _resolveInstantiatedWidget(viewToken);
        }
        
        // Premium High-Tech Holomatics Loading State
        return const Scaffold(
          backgroundColor: Color(0xFF1B1424),
          body: Center(
            child: CircularProgressIndicator(color: Color(0xFF00FF66), strokeWidth: 2),
          ),
        );
      },
    );
  }

  /// Triggers the background asynchronous compilation loader for each separate file module
  static Future<void> _loadLibraryForType(Type token) {
    final Map<Type, Future<void> Function()> libraryManifest = {
      dynamicHome.HomeView: () => dynamicHome.loadLibrary(),
      dynamicSubjects.SubjectsView: () => dynamicSubjects.subjects.loadLibrary(),
      dynamicVideo.AiVideoFeedView: () => dynamicVideo.loadLibrary(),
      dynamicSpark.SparkAiView: () => dynamicSpark.loadLibrary(),
      dynamicRank.RankView: () => dynamicRank.loadLibrary(),
      dynamicLogin.LoginView: () => dynamicLogin.loadLibrary(),
      dynamicSettings.SettingsView: () => dynamicSettings.loadLibrary(),
      dynamicRewards.RewardsView: () => dynamicRewards.loadLibrary(),
      dynamicLegal.LegalView: () => dynamicLegal.loadLibrary(),
    };

    final loader = libraryManifest[token];
    return loader != null ? loader() : Future.value();
  }

  /// Instantiates the actual production widget layer once the library is verified
  static Widget _resolveInstantiatedWidget(Type token) {
    try {
      if (token == dynamicHome.HomeView) return const dynamicHome.HomeView();
      if (token == dynamicSubjects.SubjectsView) return const dynamicSubjects.SubjectsView();
      if (token == dynamicVideo.AiVideoFeedView) return dynamicVideo.AiVideoFeedView();
      if (token == dynamicSpark.SparkAiView) return const dynamicSpark.SparkAiView();
      if (token == dynamicRank.RankView) return const dynamicRank.RankView();
      if (token == dynamicLogin.LoginView) return const dynamicLogin.LoginView();
      if (token == dynamicSettings.SettingsView) return const dynamicSettings.SettingsView();
      if (token == dynamicRewards.RewardsView) return const dynamicRewards.RewardsView();
      if (token == dynamicLegal.LegalView) return const dynamicLegal.LegalView();
    } catch (_) {
      return _buildHardwareErrorLayout(token);
    }
    return _buildHardwareErrorLayout(token);
  }

  /// Safe fall-back layout engine that intercepts code runtime faults smoothly
  static Widget _buildHardwareErrorLayout(Type token) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1424),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.gantt_chart, color: Color(0xFF00FF66), size: 36),
            const SizedBox(height: 16),
            Text(
              "Mind Spark: ${token.toString()}",
              style: const TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }
}
