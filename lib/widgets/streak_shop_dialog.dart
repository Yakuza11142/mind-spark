import 'package:flutter/material.dart';

class StreakShopDialog extends StatelessWidget {
  final int currentSparks;
  final VoidCallback onBuyShieldPressed;

  const StreakShopDialog({
    Key? key,
    required this.currentSparks,
    required this.onBuyShieldPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF0F172A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.shopping_bag_rounded, color: Colors.amber, size: 48),
            const SizedBox(height: 12),
            const Text(
              'Streak & Protection Shop',
              style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Available Sparks: $currentSparks',
              style: const TextStyle(color: Colors.amberAccent, fontSize: 13),
            ),
            const SizedBox(height: 20),
            ListTile(
              leading: const Icon(Icons.shield_rounded, color: Colors.blueAccent),
              title: const Text('Streak Freeze Shield', style: TextStyle(color: Colors.white, fontSize: 14)),
              subtitle: const Text('Protects your streak for 1 missed day', style: TextStyle(color: Colors.white54, fontSize: 11)),
              trailing: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
                onPressed: onBuyShieldPressed,
                child: const Text('50 Sparks', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Close', style: TextStyle(color: Colors.white70)),
            ),
          ],
        ),
      ),
    );
  }
}
