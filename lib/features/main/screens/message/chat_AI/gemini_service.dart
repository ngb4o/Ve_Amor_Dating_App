import 'dart:convert';
import 'package:http/http.dart' as http;

class GeminiService {
  final String apiKey;
  static const String baseUrl = 'https://generativelanguage.googleapis.com/v1beta/models/gemini-pro:generateContent';

  GeminiService(this.apiKey);

  Future<String> sendMessage(String message) async {
    try {
      final uri = Uri.parse('$baseUrl?key=$apiKey');
      final response = await http.post(
        uri,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': message}
              ]
            }
          ],
          'generationConfig': {
            'temperature': 0.7,
            'maxOutputTokens': 256,
          }
        }),
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);
        return responseData['candidates'][0]['content']['parts'][0]['text'] ?? 'No response';
      } else {
        print('API Error: ${response.body}');
        print('Status Code: ${response.statusCode}');
        return 'Connection error. Please try again.';
      }
    } catch (e) {
      print('Exception in API call: $e');
      return 'An error occurred. Check your network connection.';
    }
  }
}
