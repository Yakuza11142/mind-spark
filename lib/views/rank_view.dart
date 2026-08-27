import 'package:flutter/material.dart';

class RankView extends StatelessWidget {
  const RankView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F172A),
      appBar: AppBar(
        title: const Text('Spark Leaderboard & Ranks'),
        backgroundColor: const Color(0xFF1E293B),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withOpacity(0.4)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Your Current Rank', style: TextStyle(color: Colors.white54, fontSize: 14)),
                      SizedBox(height: 4),
                      Text('Elite Pathfinder', style: TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  ),
                  Icon(Icons.military_tech, size: 48, color: Colors.amber),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
