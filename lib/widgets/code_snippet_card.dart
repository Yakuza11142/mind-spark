import 'package:flutter/material.dart';

class CodeSnippetCard extends StatelessWidget {
  final String code;
  final String language;

  const CodeSnippetCard({Key? key, required this.code, this.language = 'dart'}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFF090D16),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade800),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.toUpperCase(), style: const TextStyle(color: Colors.purpleAccent, fontSize: 10, fontWeight: FontWeight.bold)),
          const SizedBox(height: 6),
          Text(code, style: const TextStyle(color: Colors.lightGreenAccent, fontFamily: 'monospace', fontSize: 12)),
        ],
      ),
    );
  }
}
