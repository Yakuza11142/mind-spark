import 'package:flutter/foundation.dart';

class AppLogger {
  static void log(String message, {String tag = 'MIND_SPARK'}) {
    if (kDebugMode) {
      print('[$tag] ${DateTime.now().toIso8601String()}: $message');
    }
  }

  static void error(String message, [Object? error, StackTrace? stackTrace]) {
    if (kDebugMode) {
      print('[ERROR] $message');
      if (error != null) print('Details: $error');
      if (stackTrace != null) print('Stacktrace:\n$stackTrace');
    }
  }
}
