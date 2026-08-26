import 'package:flutter/material.dart';

class StreakRepairOffer extends StatelessWidget {
  final int streakDays;
  final VoidCallback onRepairPressed;
  final VoidCallback onDismiss;

  const StreakRepairOffer({
    Key? key,
    required this.streakDays,
    required this.onRepairPressed,
    required this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color(0xFF1E1B4B),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Row(
        children: [
          const Icon(Icons.local_fire_department_rounded, color: Colors.orange, size: 28),
          const SizedBox(width: 8),
          const Text('Protect Your Streak!', style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
      content: Text(
        'You missed yesterday! Repair your $streakDays-day streak now using sparks or your daily recovery grace.',
        style: const TextStyle(color: Colors.white70, fontSize: 13),
      ),
      actions: [
        TextButton(
          onPressed: onDismiss,
          child: const Text('Let it Reset', style: TextStyle(color: Colors.grey)),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.orange,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          onPressed: onRepairPressed,
          child: const Text('Repair Streak'),
        ),
      ],
    );
  }
}
