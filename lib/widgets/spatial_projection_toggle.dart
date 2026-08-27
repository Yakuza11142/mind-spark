// Dedicated Spatial Projection Toggle Widget for Mind Spark Elite
// Drop this component directly into your main navigation bar or app header.

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SpatialProjectionToggle extends StatefulWidget {
  final ValueChanged<bool> onToggleChanged;

  const SpatialProjectionToggle({
    Key? key,
    required this.onToggleChanged,
  }) : super(key: key);

  @override
  State<SpatialProjectionToggle> createState() => _SpatialProjectionToggleState();
}

class _SpatialProjectionToggleState extends State<SpatialProjectionToggle> {
  bool _isSpatialActive = false;

  void _handleToggle() {
    setState(() {
      _isSpatialActive = !_isSpatialActive;
    });
    
    // Provide tactile haptic feedback on switch activation
    HapticFeedback.mediumImpact();
    
    // Pass the state up to the main app layout to transition views
    widget.onToggleChanged(_isSpatialActive);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleToggle,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: _isSpatialActive 
              ? Colors.cyanAccent.withOpacity(0.2) 
              : const Color(0xFF111C31),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: _isSpatialActive ? Colors.cyanAccent : Colors.cyanAccent.withOpacity(0.4),
            width: 1.5,
          ),
          boxShadow: [
            if (_isSpatialActive)
              BoxShadow(
                color: Colors.cyanAccent.withOpacity(0.3),
                blurRadius: 12,
                spreadRadius: 1,
              ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              _isSpatialActive ? Icons.view_in_ar : Icons.dashboard_rounded,
              color: Colors.cyanAccent,
              size: 18,
            ),
            const SizedBox(height: 0, width: 8),
            Text(
              _isSpatialActive ? "6FT SPATIAL MODE" : "STANDARD DASHBOARD",
              style: const TextStyle(
                color: Colors.cyanAccent,
                fontSize: 11,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
