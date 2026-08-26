import 'package:flutter/material.dart';

class AudioPlayerBubble extends StatelessWidget {
  final String label;
  final VoidCallback onPlayPressed;

  const AudioPlayerBubble({
    Key? key,
    required this.label,
    required this.onPlayPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: const Color(0xFF1E1B4B),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.indigo.shade300),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.play_arrow_rounded, color: Colors.amber),
            onPressed: onPlayPressed,
          ),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(color: Colors.white70, fontSize: 13),
            ),
          ),
          const Icon(Icons.volume_up_rounded, color: Colors.white54, size: 18),
          const SizedBox(width: 8),
        ],
      ),
    );
  }
}
