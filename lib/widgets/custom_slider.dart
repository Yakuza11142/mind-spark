import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const CustomSlider({Key? key, required this.value, required this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slider(
      value: value,
      min: 0,
      max: 100,
      activeColor: Colors.amber,
      inactiveColor: Colors.indigo.shade900,
      onChanged: onChanged,
    );
  }
}
