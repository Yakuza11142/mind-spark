import 'package:flutter/material.dart';

class AnimatedBackgroundGlow extends StatefulWidget {
  final Widget child;

  const AnimatedBackgroundGlow({Key? key, required this.child}) : super(key: key);

  @override
  State<AnimatedBackgroundGlow> createState() => _AnimatedBackgroundGlowState();
}

class _AnimatedBackgroundGlowState extends State<AnimatedBackgroundGlow> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
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
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.topCenter,
              radius: 1.2,
              colors: [
                const Color(0xFF312E81).withOpacity(0.6 + (_controller.value * 0.2)),
                const Color(0xFF0F172A),
              ],
            ),
          ),
          child: widget.child,
        );
      },
    );
  }
}
