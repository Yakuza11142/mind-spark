import 'package:flutter/material.dart';

class TypewriterTitle extends StatelessWidget {
  final String title;

  const TypewriterTitle({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 22,
        fontWeight: FontWeight.w900,
        letterSpacing: 0.5,
      ),
    );
  }
}
