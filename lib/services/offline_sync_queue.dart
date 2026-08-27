import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class OfflineSyncQueue {
  static const String _queueKey = 'spark_sync_queue_items';

  // Add a failed payload action to the offline queue
  static Future<void> enqueueAction(Map<String, dynamic> actionData) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentQueue = prefs.getStringList(_queueKey) ?? [];
    
    currentQueue.add(jsonEncode(actionData));
    await prefs.setStringList(_queueKey, currentQueue);
  }

  // Fetch all pending offline actions
  static Future<List<Map<String, dynamic>>> getPendingActions() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> currentQueue = prefs.getStringList(_queueKey) ?? [];

    return currentQueue
        .map((item) => jsonDecode(item) as Map<String, dynamic>)
        .toList();
  }

  // Clear or sync queue after successful network restoration
  static Future<void> clearQueue() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_queueKey);
  }
}
