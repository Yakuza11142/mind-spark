import 'package:flutter/services.dart';

class HapticFeedbackHelper {
  static void lightImpact() {
    HapticFeedback.lightImpact();
  }

  static void heavyImpact() {
    HapticFeedback.heavyImpact();
  }
}
