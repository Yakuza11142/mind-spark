import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static const String _syncKey = 'mind_spark_offline_queue';

  // Save string data locally
  static Future<void> saveData(String key, String value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(key, value);
  }

  // Retrieve string data locally
  static Future<String?> getData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(key);
  }

  // Clear local record
  static Future<void> clearData(String key) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(key);
  }
}
