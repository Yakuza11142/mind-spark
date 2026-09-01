import 'package:flutter/material.dart';

/// 🧠 UNIFIED INFRASTRUCTURE NAVIGATION CONTROLLER
/// 100% decoupled from explicit string mappings and static file imports.
class AppRoutes {
  // Global type token factory repository registry
  static final Map<Type, WidgetBuilder> _registryHub = {};

  /// Registers an application view module into the tracking framework dynamically
  static void registerComponentView<T extends Widget>(WidgetBuilder builder) {
    _registryHub[T] = builder;
  }

  /// ⚙️ Core Generation Routine linking visual paths to registered tokens
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Dynamically captures the runtime token type argument configuration
    final Type targetViewToken = (settings.arguments is Type)
        ? (settings.arguments as Type)
        : Container; // Soft default fallback container

    final WidgetBuilder? verifiedBuilder = _registryHub[targetViewToken];

    return MaterialPageRoute(
      settings: settings,
      builder: (BuildContext context) {
        if (verifiedBuilder != null) {
          try {
            return verifiedBuilder(context);
          } catch (_) {
            return _buildSafetyPipelineFallback(targetViewToken);
          }
        }
        return _buildSafetyPipelineFallback(targetViewToken);
      },
    );
  }

  /// System fallback viewport that intercepts rendering structural faults smoothly
  static Widget _buildSafetyPipelineFallback(Type token) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1424),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.auto_awesome, color: Color(0xFF00FF66), size: 36),
            const SizedBox(height: 16),
            Text(
              "Mind Spark: ${token.toString()}",
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 13,
                letterSpacing: 0.5,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
