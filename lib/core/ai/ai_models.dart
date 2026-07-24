// lib/core/ai/ai_models.dart

class AiCustomerSummary {
  final String summary;
  final String sentiment; // Positive, Neutral, Churn Risk
  final String suggestedNextAction;
  final double potentialValue;

  const AiCustomerSummary({
    required this.summary,
    required this.sentiment,
    required this.suggestedNextAction,
    required this.potentialValue,
  });
}

class AiDuplicateAnalysis {
  final double matchScore; // 0.0 to 1.0
  final List<String> conflictingFields;
  final String recommendedMasterRecord;
  final String reasoning;

  const AiDuplicateAnalysis({
    required this.matchScore,
    required this.conflictingFields,
    required this.recommendedMasterRecord,
    required this.reasoning,
  });
}