import 'package:flutter/material.dart';

class PulseRing extends StatefulWidget {
  final Widget child;
  final Color color;

  const PulseRing({
    Key? key,
    required this.child,
    this.color = Colors.purpleAccent,
  }) : super(key: key);

  @override
  State<PulseRing> createState() => _PulseRingState();
}

class _PulseRingState extends State<PulseRing> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();
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
            shape: BoxShape.circle,
            border: Border.all(
              color: widget.color.withOpacity(1.0 - _controller.value),
              width: 2.0 * (1.0 + _controller.value),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: widget.child,
          ),
        );
      },
    );
  }
}
