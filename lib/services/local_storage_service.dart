import 'dart:io';
import 'dart:convert';

class LocalStorageService {
  static Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> _getLocalFile(String fileName) async {
    final path = await _localPath;
    return File('$path/$fileName.json');
  }

  static Future<void> saveData(String key, Map<String, dynamic> data) async {
    try {
      final file = await _getLocalFile(key);
      await file.writeAsString(jsonEncode(data));
    } catch (_) {
      // Fail silently or handle locally
    }
  }

  static Future<Map<String, dynamic>?> readData(String key) async {
    try {
      final file = await _getLocalFile(key);
      if (!await file.exists()) return null;
      final contents = await file.readAsString();
      return jsonDecode(contents) as Map<String, dynamic>;
    } catch (_) {
      return null;
    }
  }
}
