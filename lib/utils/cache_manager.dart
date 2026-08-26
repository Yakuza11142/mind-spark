class CacheManager {
  static final Map<String, dynamic> _memoryCache = {};

  static void cacheData(String key, dynamic data) {
    _memoryCache[key] = data;
  }

  static dynamic getData(String key) {
    return _memoryCache[key];
  }
}
