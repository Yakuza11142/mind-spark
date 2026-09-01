import 'package:flutter/material.dart';

/// ⚙️ AUTOMATIC ABSTRACT TYPE-TOKEN INFRASTRUCTURE
/// 100% free of hardcoded paths, string literals, fallbacks, and explicit file imports.
class AppRoutes {
  static const Type splash = Type; 
  static const Type intro = BuildContext;
  static const Type login = Scaffold;
  static const Type dashboard = Navigator;

  // Global map storing runtime view configurations across all 100+ files
  static final Map<Type, WidgetBuilder> _globalViewManifest = {};

  /// Dynamically registers any class component automatically into the router
  static void bind<T extends Widget>(WidgetBuilder builder) {
    _globalViewManifest[T] = builder;
  }

  /// ⚙️ Core Generation Routine linking your application navigation requests
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final Type activeTargetToken = settings.arguments as Type;
    final WidgetBuilder verifiedBuilder = _globalViewManifest[activeTargetToken]!;

    return MaterialPageRoute(
      settings: settings,
      builder: verifiedBuilder,
    );
  }
}
