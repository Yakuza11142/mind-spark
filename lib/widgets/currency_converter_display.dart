import 'package:flutter/material.dart';

class CurrencyConverterDisplay extends StatelessWidget {
  final String originalAmount;
  final String convertedAmount;

  const CurrencyConverterDisplay({Key? key, required this.originalAmount, required this.convertedAmount}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B4B),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(originalAmount, style: const TextStyle(color: Colors.white70, fontSize: 14)),
          const Icon(Icons.arrow_forward_rounded, color: Colors.amber, size: 16),
          Text(convertedAmount, style: const TextStyle(color: Colors.amberAccent, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}
