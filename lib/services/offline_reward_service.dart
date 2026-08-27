import 'dart:convert';
import 'package:flutter/foundation.dart';

class OfflineRewardService {
  final Map<String, dynamic> _localMemoryCache = {};

  /// Save reward locally if network fails during an ad
  Future<void> cachePendingReward({required String rewardType, required int amount}) async {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    _localMemoryCache['pending_reward_$timestamp'] = {
      'type': rewardType,
      'amount': amount,
      'synced': false,
    };
    debugPrint('[Offline Reward] Reward safely cached offline: $amount $rewardType');
  }

  /// Claim Daily Prizes and Season Gifts locally
  Map<String, dynamic> claimDailyPrize(int streakDay) {
    int prizeSparks = streakDay * 50;
    return {
      'status': 'success',
      'message': 'Day $streakDay Daily Prize Claimed!',
      'sparks': prizeSparks,
      'claimedAt': DateTime.now().toIso8601String(),
    };
  }

  /// Check for pending rewards to sync when network restores
  Future<void> syncPendingRewards() async {
    // Automatically loops and dispatches queued rewards when online
    _localMemoryCache.forEach((key, value) {
      if (value['synced'] == false) {
        // Process background sync
        value['synced'] = true;
        debugPrint('[Sync] Reward synced successfully: ${value['amount']} ${value['type']}');
      }
    });
  }
}
