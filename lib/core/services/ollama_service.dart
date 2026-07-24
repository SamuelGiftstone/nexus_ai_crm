// lib/core/services/ollama_service.dart

import 'dart:convert';
import 'package:http/http.dart' as http;

// lib/core/services/ollama_service.dart

class OllamaService {
  final String baseUrl;
  final String model;

  OllamaService({
    this.baseUrl = 'http://127.0.0.1:11434',
    this.model = 'gemma3:1b', // Updated to match your local model tag
  });

  // ... rest of the file

  /// Getter alias for health check compatibility across services
  Future<bool> isAvailable() => checkHealth();

  /// Check if local Ollama daemon is running and Gemma model is ready
  Future<bool> checkHealth() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/api/tags'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final models = (data['models'] as List?) ?? [];
        return models.any((m) => m['name'].toString().contains('gemma'));
      }
      return false;
    } catch (_) {
      return false;
    }
  }

  /// Sends structured system prompt and CRM context directly to local Gemma (non-streaming)
  Future<String> generateResponse({
    required String prompt,
    required String crmContextJson,
  }) async {
    final systemPrompt = '''
You are Gemma, the embedded Business AI Operating System for Nexus AI CRM.
You operate entirely offline on local business data.
Always provide factual, actionable, and concise responses.

Current System Data Context:
$crmContextJson
''';

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/api/generate'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'model': model,
          'prompt': '$systemPrompt\n\nUser Request: $prompt',
          'stream': false,
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['response'] ?? 'No response generated from Gemma.';
      } else {
        return 'Error: Gemma returned status code ${response.statusCode}';
      }
    } catch (e) {
      return 'Failed to reach local Gemma instance. Please verify Ollama is active on $baseUrl. ($e)';
    }
  }

  /// Streams chunks from Ollama in real-time as NDJSON tokens arrive
  Stream<String> generateStream({
    required String prompt,
    String? systemPrompt,
  }) async* {
    final formattedSystemPrompt = systemPrompt ??
        'You are Gemma, the embedded Business AI Operating System for Nexus AI CRM.';

    final request = http.Request('POST', Uri.parse('$baseUrl/api/generate'))
      ..headers['Content-Type'] = 'application/json'
      ..body = jsonEncode({
        'model': model,
        'system': formattedSystemPrompt,
        'prompt': prompt,
        'stream': true,
      });

    final response = await request.send();

    if (response.statusCode != 200) {
      throw Exception('Ollama error status code: ${response.statusCode}');
    }

    yield* response.stream
        .transform(utf8.decoder)
        .transform(const LineSplitter())
        .map((line) {
          if (line.trim().isEmpty) return '';
          try {
            final data = jsonDecode(line);
            return (data['response'] as String?) ?? '';
          } catch (_) {
            return '';
          }
        })
        .where((chunk) => chunk.isNotEmpty);
  }
}