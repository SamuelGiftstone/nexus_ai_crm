// lib/core/services/gemma_service.dart

import 'ollama_service.dart';
import '../ai/ai_prompts.dart';

class GemmaService {
  final OllamaService _ollamaService;

  GemmaService({OllamaService? ollamaService})
      : _ollamaService = ollamaService ?? OllamaService();

  /// Streams structured response for AI Copilot chat/querying
  Stream<String> streamCopilotResponse(String prompt) {
    return _ollamaService.generateStream(
      prompt: prompt,
      systemPrompt: AiPrompts.systemCopilot,
    );
  }

  /// Helper to aggregate stream chunks into a single String
  Future<String> _getSingleResponse({
    required String prompt,
    String? systemPrompt,
  }) async {
    final chunks = await _ollamaService
        .generateStream(prompt: prompt, systemPrompt: systemPrompt)
        .toList();
    return chunks.join();
  }

  /// Generates a professional draft email reply for a contact
  Future<String> generateEmailReply({
    required String contactName,
    required String company,
    required String messageHistory,
  }) async {
    final prompt = AiPrompts.buildEmailReplyPrompt(
      contactName: contactName,
      company: company,
      messageHistory: messageHistory,
    );

    return await _getSingleResponse(
      prompt: prompt,
      systemPrompt: AiPrompts.systemSalesAssistant,
    );
  }

  /// Summarizes interaction timeline into executive bullet points
  Future<String> summarizeTimeline(String timelineText) async {
    final prompt = AiPrompts.buildSummaryPrompt(timelineText);
    return await _getSingleResponse(
      prompt: prompt,
      systemPrompt: AiPrompts.systemSummarizer,
    );
  }

  /// Analyzes duplicate lead confidence score
  Future<String> evaluateDuplicateConfidence({
    required String recordA,
    required String recordB,
  }) async {
    final prompt =
        'Compare Record A:\n$recordA\n\nWith Record B:\n$recordB\n\nDetermine if they are duplicates and specify merge suggestions.';
    return await _getSingleResponse(
      prompt: prompt,
      systemPrompt: AiPrompts.systemDuplicateAnalyzer,
    );
  }
}