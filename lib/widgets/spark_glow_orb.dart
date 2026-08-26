import 'package:flutter/material.dart';

class SparkGlowOrb extends StatefulWidget {
  final double size;
  final VoidCallback? onTap;

  const SparkGlowOrb({
    Key? key,
    this.size = 60.0,
    this.onTap,
  }) : super(key: key);

  @override
  State<SparkGlowOrb> createState() => _SparkGlowOrbState();
}

class _SparkGlowOrbState extends State<SparkGlowOrb> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return GestureDetector(
          onTap: widget.onTap,
          child: Container(
            width: widget.size,
            height: widget.size,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const RadialGradient(
                colors: [Color(0xFFFFEE55), Color(0xFFF59E0B), Color(0xFFB45309)],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.amber.withOpacity(0.5 + (_controller.value * 0.4)),
                  blurRadius: 12 + (_controller.value * 10),
                  spreadRadius: 2 + (_controller.value * 4),
                ),
              ],
            ),
            child: const Center(
              child: Icon(Icons.bolt_rounded, color: Colors.white, size: 30),
            ),
          ),
        );
      },
    );
  }
}
