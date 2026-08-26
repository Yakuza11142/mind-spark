import 'dart:convert';
import 'dart:io';

class NativeSupabaseClient {
  static const String supabaseUrl = 'YOUR_SUPABASE_URL';
  static const String supabaseAnonKey = 'YOUR_SUPABASE_ANON_KEY';

  // Example: Sign up or log in using raw REST API POST request
  static Future<Map<String, dynamic>?> signIn(String email, String password) async {
    final client = HttpClient();
    try {
      final request = await client.postUrl(Uri.parse('$supabaseUrl/auth/v1/token?grant_type=password'));
      
      request.headers.set('apikey', supabaseAnonKey);
      request.headers.set('Content-Type', 'application/json');
      
      final body = jsonEncode({'email': email, 'password': password});
      request.add(utf8.encode(body));

      final response = await request.close();
      final responseBody = await utf8.decoder.bind(response).join();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody) as Map<String, dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }

  // Example: Fetch data from a Supabase table via REST GET request
  static Future<List<dynamic>?> fetchTableData(String tableName, String accessToken) async {
    final client = HttpClient();
    try {
      final request = await client.getUrl(Uri.parse('$supabaseUrl/rest/v1/$tableName?select=*'));
      
      request.headers.set('apikey', supabaseAnonKey);
      request.headers.set('Authorization', 'Bearer $accessToken');

      final response = await request.close();
      final responseBody = await utf8.decoder.bind(response).join();

      if (response.statusCode == 200) {
        return jsonDecode(responseBody) as List<dynamic>;
      }
      return null;
    } catch (e) {
      return null;
    } finally {
      client.close();
    }
  }
}
