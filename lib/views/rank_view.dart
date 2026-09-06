import 'package:flutter/material.dart';
import '../services/app_repository.dart';

class RankView extends StatelessWidget {
  final AppRepository _repository = AppRepository();

  RankView({super.key});

  @override
  Widget build(BuildContext context) {
    final currentRank = _repository.currentRank;
    final currentPoints = _repository.sparkPoints;
    final ranks = _repository.ranks;

    // Find current rank index and next rank
    final currentRankIndex = ranks.indexWhere((r) => r.title == currentRank);
    final currentRankData = currentRankIndex >= 0? ranks[currentRankIndex] : ranks.first;
    final nextRankData = currentRankIndex < ranks.length - 1? ranks[currentRankIndex + 1] : null;

    // Progress calculation
    final min = currentRankData.minPoints.toDouble();
    final max = nextRankData?.minPoints.toDouble()?? min + 1000;
    final progress = ((currentPoints - min) / (max - min)).clamp(0.0, 1.0);

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
            // 1. Current Rank Card
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF1E293B),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: Colors.amber.withOpacity(0.4)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('Your Current Rank', style: TextStyle(color: Colors.white54, fontSize: 14)),
                        const SizedBox(height: 4),
                        Text(currentRank, style: const TextStyle(color: Colors.amber, fontSize: 20, fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        Text('$currentPoints Spark Points', style: const TextStyle(color: Colors.white70, fontSize: 13)),
                      ],
                    ),
                  ),
                  Icon(currentRankData.badge, size: 48, color: Colors.amber),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // 2. Progress to next rank
            if (nextRankData!= null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Progress to ${nextRankData.title}', style: const TextStyle(color: Colors.white70, fontSize: 14)),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: progress,
                        minHeight: 8,
                        backgroundColor: Colors.white10,
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.indigo),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text('${currentPoints} / ${nextRankData.minPoints}', style: const TextStyle(color: Colors.white54, fontSize: 12)),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // 3. All Ranks List
            Expanded(
              child: ListView.builder(
                itemCount: ranks.length,
                itemBuilder: (context, index) {
                  final rank = ranks[index];
                  final isUnlocked = currentPoints >= rank.minPoints;
                  final isCurrent = rank.title == currentRank;

                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: isCurrent? Colors.indigo.withOpacity(0.2) : const Color(0xFF1E293B),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: isCurrent? Colors.indigo : Colors.white10,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(rank.badge, color: isUnlocked? Colors.amber : Colors.grey, size: 28),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(rank.title, style: TextStyle(
                                color: isUnlocked? Colors.white : Colors.white54,
                                fontWeight: FontWeight.w600,
                                fontSize: 15
                              )),
                              Text('${rank.minPoints} SP', style: TextStyle(
                                color: isUnlocked? Colors.white70 : Colors.white38,
                                fontSize: 12
                              )),
                            ],
                          ),
                        ),
                        if (isCurrent)
                          const Chip(
                            label: Text('Current', style: TextStyle(fontSize: 10)),
                            backgroundColor: Colors.indigo,
                            labelStyle: TextStyle(color: Colors.white),
                            padding: EdgeInsets.zero,
                          )
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}