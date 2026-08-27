import 'dart:convert';
import 'dart:io';

enum AiProvider { gemini, groq }

class AiTutorService {
  final String geminiApiKey;
  final String groqApiKey;

  AiTutorService({required this.geminiApiKey, required this.groqApiKey});

  /// Fetch response from Google Gemini API
  Future<String> fetchGeminiResponse(String prompt) async {
    final client = HttpClient();
    try {
      final url = Uri.parse(
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$geminiApiKey',
      );
      final request = await client.postUrl(url);
      request.headers.set('Content-Type', 'application/json');

      request.add(utf8.encode(jsonEncode({
        'contents': [
          {
            'parts': [
              {'text': 'You are the Mind Spark Elite AI learning companion. $prompt'}
            ]
          }
        ]
      })));

      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final data = jsonDecode(stringData);
        return data['candidates'][0]['content']['parts'][0]['text'].toString().trim();
      }
      throw HttpException('Gemini API Error: ${response.statusCode}');
    } finally {
      client.close();
    }
  }

  /// Fetch response from Groq API
  Future<String> fetchGroqResponse(String prompt) async {
    final client = HttpClient();
    try {
      final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');
      final request = await client.postUrl(url);
      request.headers.set('Content-Type', 'application/json');
      request.headers.set('Authorization', 'Bearer $groqApiKey');

      request.add(utf8.encode(jsonEncode({
        'model': 'llama-3.3-70b-versatile',
        'messages': [
          {'role': 'system', 'content': 'You are Spark.'},
          {'role': 'user', 'content': prompt}
        ],
      })));

      final response = await request.close();
      if (response.statusCode == 200) {
        final stringData = await response.transform(utf8.decoder).join();
        final data = jsonDecode(stringData);
        return data['choices'][0]['message']['content'].toString().trim();
      }
      throw HttpException('Groq API Error: ${response.statusCode}');
    } finally {
      client.close();
    }
  }

  /// Universal switcher method
  Future<String> fetchAiResponse(String prompt, {AiProvider provider = AiProvider.gemini}) async {
    if (provider == AiProvider.gemini) {
      return await fetchGeminiResponse(prompt);
    } else {
      return await fetchGroqResponse(prompt);
    }
  }
}
