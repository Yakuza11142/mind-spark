class AnalyticsService {
  final List<Map<String, dynamic>> _eventLog = [];

  void trackEvent(String eventName, Map<String, dynamic> parameters) {
    _eventLog.add({
      'event': eventName,
      'params': parameters,
      'time': DateTime.now().toIso8601String(),
    });
  }

  List<Map<String, dynamic>> get loggedEvents => List.unmodifiable(_eventLog);
}
