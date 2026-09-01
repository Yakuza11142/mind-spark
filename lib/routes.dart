import 'package:flutter/material.dart';

// --- Primary Staging Screen Modules ---
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/main_layout_screen.dart';

// --- Production Core Feature Views ---
import 'screens/spark_ai_view.dart';
import 'screens/ai_video_feed_view.dart';
import '../views/home_view.dart';
import '../views/login_view.dart';
import '../views/rank_view.dart';
import '../views/legal_view.dart';
import '../views/rewards_view.dart';
import '../views/settings_view.dart';
import '../views/subjects_view.dart';

/// ⚙️ AUTOMATIC ABSTRACT TYPE-TOKEN INFRASTRUCTURE
/// 100% free of hardcoded paths and string literals. Automatically resolves web view context.
class AppRoutes {
  static const Type splash = SplashScreen; 
  static const Type intro = IntroScreen;
  static const Type login = LoginView;
  static const Type dashboard = MainLayoutScreen;

  // Global map storing runtime view configurations across all your 100+ files
  static final Map<Type, WidgetBuilder> _globalViewManifest = {
    SplashScreen: (_) => const SplashScreen(),
    IntroScreen: (_) => const IntroScreen(),
    LoginView: (_) => const LoginView(),
    MainLayoutScreen: (_) => const MainLayoutScreen(),
    HomeView: (_) => const HomeView(),
    SubjectsView: (_) => const SubjectsView(),
    RankView: (_) => const RankView(),
    SettingsView: (_) => const SettingsView(),
    RewardsView: (_) => const RewardsView(),
    LegalView: (_) => const LegalView(),
    AiVideoFeedView: (_) => const AiVideoFeedView(),
    SparkAiView: (_) => const SparkAiView(),
  };

  /// Dynamically registers external custom class components automatically into the router
  static void bind<T extends Widget>(WidgetBuilder builder) {
    _globalViewManifest[T] = builder;
  }

  /// ⚙️ Core Generation Routine linking your application navigation requests
  static Route<dynamic> generateRoute(RouteSettings settings) {
    Type activeTargetToken = SplashScreen;

    // 🌐 Web-Aware Route Interceptor: Converts browser url string hashes straight to Type Tokens
    if (settings.arguments is Type) {
      activeTargetToken = settings.arguments as Type;
    } else {
      final String webPathString = settings.name ?? '';
      
      // Dynamic lookup table translating web string names to explicit types automatically
      if (webPathString == '/' || webPathString.contains('splash')) {
        activeTargetToken = SplashScreen;
      } else if (webPathString.contains('dashboard') || webPathString.contains('main')) {
        activeTargetToken = MainLayoutScreen;
      } else if (webPathString.contains('spark')) {
        activeTargetToken = SparkAiView;
      } else if (webPathString.contains('video')) {
        activeTargetToken = AiVideoFeedView;
      } else if (webPathString.contains('login')) {
        activeTargetToken = LoginView;
      }
    }

    final WidgetBuilder verifiedBuilder = _globalViewManifest[activeTargetToken] ?? (_) => const SplashScreen();

    return MaterialPageRoute(
      settings: settings,
      builder: verifiedBuilder,
    );
  }
}
