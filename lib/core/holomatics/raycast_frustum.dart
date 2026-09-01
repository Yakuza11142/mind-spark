import 'package:flutter/material.dart';

/// 📐 THE INERTIAL FRUSTUM SCALING COORDINATOR
/// Processes device IMU sensor telemetry to scale and anchor spatial assets
/// stably in the physical real world from 10cm miniatures up to 10ft models.
class HolomaticsRaycastFrustum {
  static const double minScaleCm = 10.0;   // Handheld floating miniature
  static const double maxScaleCm = 300.0;  // 10-Foot room asset framework

  /// Generates a 4x4 coordinate scaling matrix based on tracked device telemetry
  Matrix4 computeSpatialAnchorMatrix({
    required double currentObjectSizeCm,
    required double deviceRotationX,
    required double deviceRotationY,
  }) {
    final Matrix4 transformationMatrix = Matrix4.identity();

    // Force strict physical bounding envelope limits
    final double boundedSize = currentObjectSizeCm.clamp(minScaleCm, maxScaleCm);
    
    // Scale conversion mapping factor (Translates centimeters to screen matrix space)
    final double scalingFactor = boundedSize / 100.0;

    // Apply real-world Kinematic orientation alignment vectors (IMU Sync)
    transformationMatrix.rotateX(deviceRotationX);
    transformationMatrix.rotateY(deviceRotationY);
    transformationMatrix.scale(scalingFactor, scalingFactor, scalingFactor);

    return transformationMatrix;
  }
}
