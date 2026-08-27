import 'dart:collection';

class OfflineSyncService {
  final Queue<Map<String, dynamic> > _syncQueue = Queue();

  void queueAction(String endpoint, Map<String, dynamic> payload) {
    _syncQueue.add({
      'endpoint': endpoint,
      'payload': payload,
      'timestamp': DateTime.now().millisecondsSinceEpoch,
    });
  }

  bool get hasPendingSync => _syncQueue.isNotEmpty;

  Map<String, dynamic>? dequeueAction() {
    if (_syncQueue.isNotEmpty) {
      return _syncQueue.removeFirst();
    }
    return null;
  }
}
