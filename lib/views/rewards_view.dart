import 'package:flutter/material.dart';
import '../services/app_repository.dart';

class RewardsView extends StatelessWidget {
  final AppRepository _repository = AppRepository();
  final VoidCallback onStateMutation;

  RewardsView({super.key, required this.onStateMutation});

  @override
  Widget build(BuildContext context) {
    final bool claimed = _repository.dynamicPrizeClaimed;

    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Daily Prizes & Rewards'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Daily Streak Prize', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(
                    claimed ? 'Prize claimed for today!' : 'Claim safe offline rewards instantly', 
                    style: const TextStyle(color: Colors.white54, fontSize: 13),
                  ),
                ],
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: claimed ? Colors.grey : Colors.indigo),
                onPressed: claimed ? null : () {
                  if (_repository.executeDailyClaim()) {
                    onStateMutation();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Claimed Sparks successfully!')),
                    );
                  }
                },
                child: Text(claimed ? 'Claimed' : 'Claim', style: const TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
