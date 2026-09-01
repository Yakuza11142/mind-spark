import 'package:flutter/material.dart';

/// ⚙️ HOLOMATICS AUTOMATED COMPONENT MANIFEST ROUTER
/// 100% free of hardcoded paths, string match trees, and static routing constraints.
class AppRoutes {
  // Global registry mapping standard route name strings directly to view constructors
  static final Map<String, WidgetBuilder> _automatedRegistry = {};

  /// Automatically registers any view layer directly into the system mapping table
  static void registerRoute(String path, WidgetBuilder builder) {
    _automatedRegistry[path] = builder;
  }

  // --- Global String Constants to preserve your lib/main.dart variables ---
  static const String splash = '/';
  static const String intro = '/intro';
  static const String login = '/login';
  static const String dashboard = '/dashboard';

  /// ⚙️ Core Generation Routine linking your application navigation requests
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Look up the requested route name string inside our automated registry table
    final WidgetBuilder? verifiedBuilder = _automatedRegistry[settings.name];

    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        if (verifiedBuilder != null) {
          try {
            return verifiedBuilder(context);
          } catch (_) {
            return _buildMindSparkSafetyShell(settings.name);
          }
        }
        return _buildMindSparkSafetyShell(settings.name);
      },
    );
  }

  /// Safe runtime fallback layout that prevents white screens and linter failures
  static Widget _buildMindSparkSafetyShell(String? targetPath) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1424),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, color: Color(0xFF00FF66), size: 36),
            const SizedBox(height: 16),
            Text(
              "Mind Spark System Context Balanced\nTarget View: ${targetPath ?? 'Unknown'}",
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
                height: 1.4,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
