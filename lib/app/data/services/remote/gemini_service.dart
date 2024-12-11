import 'package:google_generative_ai/google_generative_ai.dart';

class GeminiService {
  final String apiKey = 'AIzaSyAUeVpBAbEulMzxyabLy0wAMT_-Bsc4ObA'; 
  late GenerativeModel _model;

  GeminiService() {
    _initializeModel();
  }

  void _initializeModel() {
    _model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);
  }

  Future<String> generateContent(String prompt) async {
    try {
      final content = [Content.text(prompt)];
      final result = await _model.generateContent(content);
      return result.text ?? 'No response received.';
    } catch (e) {
      throw Exception('Error generating content: $e');
    }
  }
}
