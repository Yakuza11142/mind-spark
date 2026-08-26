import 'package:flutter/material.dart';

class BadgeUnlockPopup extends StatelessWidget {
  final String badgeName;
  final VoidCallback onClaim;

  const BadgeUnlockPopup({
    Key? key,
    required this.badgeName,
    required this.onClaim,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF0F172A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.military_tech_rounded, color: Colors.amber, size: 64),
          const SizedBox(height: 12),
          const Text('New Badge Unlocked!', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Text(badgeName, style: const TextStyle(color: Colors.amberAccent, fontSize: 15, fontWeight: FontWeight.w600)),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.amber, foregroundColor: Colors.black),
            onPressed: onClaim,
            child: const Text('Awesome!'),
          ),
        ],
      ),
    );
  }
}
