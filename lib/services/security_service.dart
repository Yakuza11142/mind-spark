import 'dart:convert';

class SecurityService {
  static final List<String> _badWords = ['badword1', 'badword2'];

  bool validatePayload(String content) {
    final lower = content.toLowerCase();
    for (var word in _badWords) {
      if (lower.contains(word)) return false;
    }
    return true;
  }

  String simpleHash(String text) {
    // Pure Dart basic string encoding hash fallback
    return base64Encode(utf8.encode(text));
  }
}
