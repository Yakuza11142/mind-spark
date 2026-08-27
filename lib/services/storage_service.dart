import 'dart:io';

class StorageService {
  final Map<String, String> _memoryCache = {};

  Future<void> saveValue(String key, String value) async {
    _memoryCache[key] = value;
  }

  Future<String?> getValue(String key) async {
    return _memoryCache[key];
  }

  void clear() {
    _memoryCache.clear();
  }
}
