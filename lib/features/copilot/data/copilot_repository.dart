// lib/features/copilot/data/copilot_repository.dart

import 'dart:convert';
import '../../../core/services/ollama_service.dart';
import '../../copilot/domain/copilot_message.dart';

class CopilotRepository {
  final OllamaService _ollamaService;

  CopilotRepository({OllamaService? ollamaService})
      : _ollamaService = ollamaService ?? OllamaService();

  Future<CopilotMessage> processPrompt(String userQuery) async {
    // 1. Gather relevant local context (e.g., active deals, high value leads)
    final localCrmContext = await _retrieveLocalCrmDataSummary();

    // 2. Query Gemma locally
    final rawAiResult = await _ollamaService.generateResponse(
      prompt: userQuery,
      crmContextJson: jsonEncode(localCrmContext),
    );

    // 3. Format into a structured response
    return CopilotMessage(
      id: 'msg_${DateTime.now().millisecondsSinceEpoch}',
      content: rawAiResult,
      sender: CopilotSender.assistant,
      timestamp: DateTime.now(),
      suggestedActions: const [
        'Export Summary',
        'Schedule Follow-up',
        'Create Deal',
      ],
    );
  }

  /// Extracts compact database state to pass inside Gemma's context window
  Future<Map<String, dynamic>> _retrieveLocalCrmDataSummary() async {
    // Return structured snapshot from Drift SQLite
    return {
      "summary": {
        "total_active_leads": 14,
        "pending_quotations_val": "\$24,500",
        "overdue_followups": 3,
      },
      "recent_contacts": [
        {"name": "John Doe", "status": "Negotiating", "last_contacted": "3 days ago"},
        {"name": "Acme Corp", "status": "Proposal Sent", "last_contacted": "Yesterday"}
      ]
    };
  }
}