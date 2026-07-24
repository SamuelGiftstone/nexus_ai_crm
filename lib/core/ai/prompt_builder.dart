// lib/core/ai/prompt_builder.dart

abstract class PromptBuilder {
  static String buildEmailReplyPrompt({
    required String contactName,
    required String company,
    required String messageHistory,
  }) {
    return '''
Contact: $contactName
Company: $company
Recent Communication:
$messageHistory

Task: Draft a concise, high-converting email reply addressing the client's latest query while maintaining a warm, professional tone.
''';
  }

  static String buildSummaryPrompt(String timelineText) {
    return '''
Interaction Timeline:
$timelineText

Task: Summarize key progress, outline sentiment, and list the immediate next action item.
''';
  }

  static String buildRiskAnalysisPrompt({
    required String customerName,
    required double totalRevenue,
    required int daysSinceLastContact,
  }) {
    return '''
Customer: $customerName
Annual Revenue: \$$totalRevenue
Days Since Last Contact: $daysSinceLastContact

Task: Evaluate churn risk based on activity gaps and suggest a retention action.
''';
  }
}