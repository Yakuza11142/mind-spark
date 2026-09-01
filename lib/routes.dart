import 'package:flutter/material.dart';

// 🏗️ Stable Base Framework Shell Frames (Clean Compile-Time Imports)
import 'screens/splash_screen.dart';
import 'screens/intro_screen.dart';
import 'screens/main_layout_screen.dart';

// 🚀 Core Feature View Modules (Natively tracked without hardcoded path strings)
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
/// 100% free of hardcoded paths and string literals. Automatically resolves view context.
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
    AiVideoFeedView: (_) => AiVideoFeedView(),
    SparkAiView: (_) => const SparkAiView(),
  };

  /// Dynamically registers external custom class components automatically into the router
  static void bind<T extends Widget>(WidgetBuilder builder) {
    _globalViewManifest[T] = builder;
  }

  /// ⚙️ Core Generation Routine linking your application navigation requests
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // If no explicit type token argument is specified, default straight to Splash view
    final Type activeTargetToken = (settings.arguments is Type)
        ? (settings.arguments as Type)
        : SplashScreen;

    final WidgetBuilder verifiedBuilder = _globalViewManifest[activeTargetToken]!;

    return MaterialPageRoute(
      settings: settings,
      builder: verifiedBuilder,
    );
  }
}
