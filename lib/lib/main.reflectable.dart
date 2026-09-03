import 'package:flutter/material.dart';

// Import your custom feature assets cleanly in this isolated space
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/main_layout_screen.dart';
import 'screens/spark_ai_view.dart';
import 'screens/ai_video_feed_view.dart';

class MindSparkRegistry {
  /// ⚙️ Automatically resolves web string paths directly to view structures
  static Route<dynamic> resolveWebAndNativeRoutes(RouteSettings settings) {
    final String path = settings.name ?? '/';

    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        if (path == '/' || path.contains('splash')) return const SplashScreen();
        if (path.contains('intro')) return const IntroScreen();
        if (path.contains('dashboard') || path.contains('main')) return const MainLayoutScreen();
        if (path.contains('video')) return const Scaffold(body: Center(child: AiVideoFeedView()));
        if (path.contains('spark')) return const Scaffold(body: Center(child: SparkAiView()));
        
        return const SplashScreen();
      },
    );
  }
}
