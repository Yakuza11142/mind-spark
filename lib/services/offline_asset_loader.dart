import 'dart:convert';
import 'package:flutter/services.dart';

class OfflineAssetLoader {
  static Future<Map<String, dynamic>> loadLocalConfig(String assetPath) async {
    try {
      final jsonString = await rootBundle.loadString(assetPath);
      return jsonDecode(jsonString) as Map<String, dynamic>;
    } catch (_) {
      return {};
    }
  }
}
