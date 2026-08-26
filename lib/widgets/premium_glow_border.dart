import 'package:flutter/material.dart';

class PremiumGlowBorder extends StatelessWidget {
  final Widget child;
  final double borderWidth;
  final BorderRadius borderRadius;

  const PremiumGlowBorder({
    Key? key,
    required this.child,
    this.borderWidth = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(16)),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        gradient: const LinearGradient(
          colors: [Colors.amber, Colors.deepOrange, Colors.purpleAccent],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.amber.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      padding: EdgeInsets.all(borderWidth),
      child: ClipRRect(
        borderRadius: borderRadius.subtract(BorderRadius.all(Radius.circular(borderWidth))),
        child: child,
      ),
    );
  }
}
