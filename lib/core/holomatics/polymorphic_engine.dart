import 'package:flutter/material.dart';
import 'dart:math' as math;

/// 🧠 THE MIND SPARK POLYMORPHIC ENGINE CORE
/// Coordinates standalone multi-object light-field spatial scaling calculations.
/// Combines an interactive 10cm-to-10ft scaling matrix with a secondary
/// shape-shifting polymorphic vector network.
class PolymorphicEngine {
  // Pure Monochromatic Neon Green Core (555nm Target Wavelength)
  static const Color photopicGreen = Color(0xFF00FF66);
  static const Color backgroundCanvas = Color(0xFF1B1424);

  /// Helper tool that exports the standardized structural painting tool rules
  Paint compileVectorBrush({
    required double pulseValue,
    bool isSecondary = false,
  }) {
    final double targetOpacity = isSecondary ? 0.40 : (0.80 + (pulseValue * 0.15));
    final double targetWidth = isSecondary ? 1.0 : 1.4;

    return Paint()
      ..color = photopicGreen.withOpacity(targetOpacity.clamp(0.0, 1.0))
      ..style = PaintingStyle.stroke
      ..strokeWidth = targetWidth
      ..isAntiAlias = true;
  }
}

/// 🎨 THE HOLOMATICS VECTOR MATRIX SHADER COMPILER
/// Draws both the scalable 6-foot primary asset and the morphing secondary asset.
class PolymorphicHologramPainter extends CustomPainter {
  final double pulseValue;
  final double morphValue;
  final double globalScale;

  PolymorphicHologramPainter({
    required this.pulseValue,
    required this.morphValue,
    required this.globalScale,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final engine = PolymorphicEngine();
    final Paint vectorPaint = engine.compileVectorBrush(pulseValue: pulseValue);
    final Paint secondaryPaint = engine.compileVectorBrush(pulseValue: pulseValue, isSecondary: true);

    final double midX = size.width / 2;
    // Map a standard 10ft tracking layout where 1 foot scales relative to global size sliders
    final double footUnit = (size.height / 10) * globalScale; 

    final double groundY = size.height - (size.height / 10 * 1.5);
    final double headY = groundY - (6.0 * footUnit);
    final double shoulderY = headY + (0.8 * footUnit);
    final double waistY = groundY - (3.2 * footUnit);

    // =========================================================================
    // 👤 1. THE PRIMARY 6-FOOT HOLOGRAPHIC ACTOR (Suitless Wireframe Layout)
    // =========================================================================
    
    // Head & Geometric Glasses Track
    final double headRadius = 0.35 * footUnit;
    canvas.drawCircle(Offset(midX, headY + headRadius), headRadius, vectorPaint);
    
    final double glassWidth = 0.18 * footUnit;
    final double glassHeight = 0.08 * footUnit;
    final Offset leftEye = Offset(midX - (0.12 * footUnit), headY + (0.3 * footUnit));
    final Offset rightEye = Offset(midX + (0.12 * footUnit), headY + (0.3 * footUnit));
    canvas.drawRect(Rect.fromCenter(center: leftEye, width: glassWidth, height: glassHeight), vectorPaint);
    canvas.drawRect(Rect.fromCenter(center: rightEye, width: glassWidth, height: glassHeight), vectorPaint);

    // Long-Sleeve Torso Contour & Parallel Texture Lines
    final double shoulderWidth = 0.9 * footUnit;
    canvas.drawLine(Offset(midX - shoulderWidth, shoulderY), Offset(midX + shoulderWidth, shoulderY), vectorPaint);
    canvas.drawLine(Offset(midX - shoulderWidth, shoulderY), Offset(midX - (0.55 * footUnit), waistY), vectorPaint);
    canvas.drawLine(Offset(midX + shoulderWidth, shoulderY), Offset(midX + (0.55 * footUnit), waistY), vectorPaint);

    for (int i = 1; i <= 4; i++) {
      double ratio = i / 5;
      double currentY = shoulderY + (waistY - shoulderY) * ratio;
      canvas.drawLine(Offset(midX - (shoulderWidth * 0.7), currentY), Offset(midX + (shoulderWidth * 0.7), currentY), vectorPaint);
    }

    // Belt & Tailored Trousers
    canvas.drawLine(Offset(midX - (0.55 * footUnit), waistY), Offset(midX + (0.55 * footUnit), waistY), vectorPaint);
    canvas.drawRect(Rect.fromCenter(center: Offset(midX, waistY), width: 20, height: 10), vectorPaint);
    
    final Offset leftAnkle = Offset(midX - (0.4 * footUnit), groundY - (0.4 * footUnit));
    final Offset rightAnkle = Offset(midX + (0.4 * footUnit), groundY - (0.4 * footUnit));
    canvas.drawLine(Offset(midX - (0.55 * footUnit), waistY), leftAnkle, vectorPaint);
    canvas.drawLine(Offset(midX + (0.55 * footUnit), waistY), rightAnkle, vectorPaint);
    canvas.drawLine(Offset(midX, waistY + 20), leftAnkle, vectorPaint);
    canvas.drawLine(Offset(midX, waistY + 20), rightAnkle, vectorPaint);

    // Dress Shoes Path Nodes
    canvas.drawLine(leftAnkle, Offset(leftAnkle.dx - (0.3 * footUnit), groundY), vectorPaint);
    canvas.drawLine(Offset(leftAnkle.dx - (0.3 * footUnit), groundY), Offset(leftAnkle.dx + 10, groundY), vectorPaint);
    canvas.drawLine(rightAnkle, Offset(rightAnkle.dx + (0.3 * footUnit), groundY), vectorPaint);
    canvas.drawLine(Offset(rightAnkle.dx + (0.3 * footUnit), groundY), Offset(rightAnkle.dx - 10, groundY), vectorPaint);

    // =========================================================================
    // 🧬 2. THE SECONDARY POLYMORPHIC HOLOGRAM (Floating Shape-Shifter Core)
    // =========================================================================
    
    // Position the secondary entity floating 2 feet to the left of the head
    final double polyX = midX - (2.0 * footUnit);
    final double polyY = headY + (1.0 * footUnit);
    final double polyRadius = 0.6 * footUnit;

    canvas.save();
    canvas.translate(polyX, polyY);
    
    // The Polymorphic Transformation Equation: Morphs continuously between a 
    // structured polygon (drone mesh frame) and a fluid wave ring (molecular axis loop).
    final int totalVertices = 8;
    final Path polyPath = Path();

    for (int i = 0; i < totalVertices; i++) {
      double angle = (i * 2 * math.pi) / totalVertices;
      
      // Dynamic radius modulation driven by the morph controller calculation value
      double morphModulator = math.sin(angle * 3 + (morphValue * 2 * math.pi)) * (0.15 * footUnit);
      double currentRadius = polyRadius + morphModulator;

      double x = currentRadius * math.cos(angle);
      double y = currentRadius * math.sin(angle);

      if (i == 0) {
        polyPath.moveTo(x, y);
      } else {
        polyPath.lineTo(x, y);
      }
    }
    polyPath.close();
    
    // Render the shape-shifting secondary geometry
    canvas.drawPath(polyPath, secondaryPaint);
    
    // Cross-cutting inner matrix tracking vectors inside the polymorph shell
    canvas.drawLine(Offset(-polyRadius, 0), Offset(polyRadius, 0), secondaryPaint);
    canvas.drawLine(Offset(0, -polyRadius), Offset(0, polyRadius), secondaryPaint);
    
    canvas.restore();
  }

  @override
  bool updateShouldNotify(covariant PolymorphicHologramPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue ||
           oldDelegate.morphValue != morphValue ||
           oldDelegate.globalScale != globalScale;
  }
}
