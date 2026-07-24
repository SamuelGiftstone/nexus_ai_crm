// lib/features/copilot/domain/copilot_message.dart

enum CopilotSender { user, assistant }

class CopilotMessage {
  final String id;
  final String content;
  final CopilotSender sender;
  final DateTime timestamp;
  final bool isThinking;
  final List<String>? suggestedActions;

  const CopilotMessage({
    required this.id,
    required this.content,
    required this.sender,
    required this.timestamp,
    this.isThinking = false,
    this.suggestedActions,
  });

  CopilotMessage copyWith({
    String? id,
    String? content,
    CopilotSender? sender,
    DateTime? timestamp,
    bool? isThinking,
    List<String>? suggestedActions,
  }) {
    return CopilotMessage(
      id: id ?? this.id,
      content: content ?? this.content,
      sender: sender ?? this.sender,
      timestamp: timestamp ?? this.timestamp,
      isThinking: isThinking ?? this.isThinking,
      suggestedActions: suggestedActions ?? this.suggestedActions,
    );
  }
}