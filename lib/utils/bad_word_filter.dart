class BadWordFilter {
  static final List<String> _forbiddenWords = ['badword1', 'badword2']; // Infinite bad word filter logic mock

  static bool containsBadWord(String text) {
    final lower = text.toLowerCase();
    return _forbiddenWords.any((word) => lower.contains(word));
  }

  static String sanitize(String text) {
    String clean = text;
    for (var word in _forbiddenWords) {
      clean = clean.replaceAll(RegExp(word, caseSensitive: false), '***');
    }
    return clean;
  }
}
