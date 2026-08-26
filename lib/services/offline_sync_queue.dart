import 'dart:convert';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class OfflineSyncQueue {
  static const String _queueFileName = 'offline_action_queue.json';

  static Future<void> queueAction(String actionType, Map<String, dynamic> payload) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_queueFileName');
      
      List<dynamic> queue = [];
      if (await file.exists()) {
        final content = await file.readAsString();
        queue = jsonDecode(content) as List<dynamic>;
      }

      queue.add({
        'type': actionType,
        'payload': payload,
        'timestamp': DateTime.now().toIso8601String(),
      });

      await file.writeAsString(jsonEncode(queue));
    } catch (_) {}
  }

  static Future<List<dynamic>> getPendingActions() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_queueFileName');
      if (!await file.exists()) return [];
      
      final content = await file.readAsString();
      return jsonDecode(content) as List<dynamic>;
    } catch (_) {
      return [];
    }
  }

  static Future<void> clearQueue() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = File('${dir.path}/$_queueFileName');
      if (await file.exists()) {
        await file.delete();
      }
    } catch (_) {}
  }
}
