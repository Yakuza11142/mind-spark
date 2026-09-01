import 'package:flutter/material.dart';

/// 📡 THE HIGH-FREQUENCY LIGHT-FIELD SUBPIXEL WEAVER
/// Slices and weaves multi-angle geometric coordinates into a single frame buffer,
/// steering the directional neon green photon channels directly into the user's pupils.
class HolomaticsSubpixelWeaver {
  
  /// Formats the graphics painter paint profile using the 555nm photopic profile
  Paint compileVectorBrush({
    required bool isAccentGlow,
    required double structuralPulse,
  }) {
    final double targetOpacity = isAccentGlow ? 0.25 : (0.80 + (structuralPulse * 0.15));
    final double targetWidth = isAccentGlow ? 3.8 : 1.4;

    return Paint()
      ..color = const Color(0xFF00FF66).withOpacity(targetOpacity.clamp(0.0, 1.0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = targetWidth
      ..isAntiAlias = true;
  }

  /// Calculates the interlaced subpixel pixel shifting coordinate offset
  double calculatePixelInterlaceOffset(int totalViews, double screenWidth) {
    if (totalViews <= 0) return 0.0;
    // Hax: Interlacing step layout width mapping formula
    return screenWidth / totalViews;
  }
}
