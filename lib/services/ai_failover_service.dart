import 'dart:convert';
import 'package:http/http.dart' as http;

class AiFailoverService {
  static const String geminiApiKey = "YOUR_GEMINI_API_KEY";
  static const String groqApiKey = "YOUR_GROQ_API_KEY";

  // Strict system prompt to prevent guessing or hallucinating facts
  static const String _antiHallucinationSystemPrompt = 
      "You are an exact educational assistant for Mind Spark. "
      "Strict Rules: Never invent facts, figures, historical dates, or code structures. "
      "If you do not know the exact answer or if information is missing from your training data, "
      "you must reply strictly with: 'I am unable to verify this information accurately.' "
      "Do not guess or extrapolate.";

  /// Sends a prompt with strict zero-hallucination configuration. 
  /// Tries Gemini first, then falls back to Groq.
  static Future<String> generateContent(String prompt) async {
    try {
      final geminiResult = await _callGemini(prompt);
      if (geminiResult != null && geminiResult.isNotEmpty) {
        return geminiResult;
      }
    } catch (_) {}

    try {
      final groqResult = await _callGroq(prompt);
      if (groqResult != null && groqResult.isNotEmpty) {
        return groqResult;
      }
    } catch (_) {}

    return "I am unable to verify this information accurately.";
  }

  static Future<String?> _callGemini(String prompt) async {
    final url = Uri.parse(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=$geminiApiKey',
    );

    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        "contents": [
          {
            "parts": [{"text": "$_antiHallucinationSystemPrompt\n\nUser Query: $prompt"}]
          }
        ],
        "generationConfig": {
          "temperature": 0.0 // Forces fully deterministic, non-creative, factual responses
        }
      }),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['candidates']?[0]?['content']?['parts']?[0]?['text'];
    }
    return null;
  }

  static Future<String?> _callGroq(String prompt) async {
    final url = Uri.parse('https://api.groq.com/openai/v1/chat/completions');

    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $groqApiKey',
      },
      body: jsonEncode({
        "model": "llama3-8b-8192",
        "temperature": 0.0, // Forces zero creativity / strict fact adherence
        "messages": [
          {"role": "system", "content": _antiHallucinationSystemPrompt},
          {"role": "user", "content": prompt}
        ]
      }),
    ).timeout(const Duration(seconds: 10));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices']?[0]?['message']?['content'];
    }
    return null;
  }
}
