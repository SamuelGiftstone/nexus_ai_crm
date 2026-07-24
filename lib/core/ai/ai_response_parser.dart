// lib/core/ai/ai_response_parser.dart

import 'dart:convert';
import 'ai_models.dart';

abstract class AiResponseParser {
  /// Extracts JSON from markdown blocks (e.g., ```json ... ```) or raw text
  static Map<String, dynamic>? parseJsonFromText(String rawText) {
    try {
      final jsonRegex = RegExp(r'\{.*\}', dotAll: true);
      final match = jsonRegex.firstMatch(rawText);
      if (match != null) {
        return jsonDecode(match.group(0)!) as Map<String, dynamic>;
      }
    } catch (_) {
      return null;
    }
    return null;
  }

  static AiCustomerSummary parseSummary(String responseText) {
    final json = parseJsonFromText(responseText);
    if (json != null) {
      return AiCustomerSummary(
        summary: json['summary'] ?? 'Summary unavailable.',
        sentiment: json['sentiment'] ?? 'Neutral',
        suggestedNextAction: json['next_action'] ?? 'Follow up via email',
        potentialValue: (json['potential_value'] as num?)?.toDouble() ?? 0.0,
      );
    }

    // Fallback parser if LLM returns plain text
    return AiCustomerSummary(
      summary: responseText,
      sentiment: 'Neutral',
      suggestedNextAction: 'Review timeline',
      potentialValue: 0.0,
    );
  }
}