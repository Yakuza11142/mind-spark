import 'package:flutter/material.dart';

class ProFeatureTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  const ProFeatureTooltip({
    Key? key,
    required this.child,
    this.message = "Upgrade to Mind Spark Elite Pro to unlock this capability.",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      padding: const EdgeInsets.all(12),
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B4B),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.amber, width: 1),
      ),
      textStyle: const TextStyle(color: Colors.white, fontSize: 12),
      child: child,
    );
  }
}
