// lib/features/copilot/bloc/copilot_state.dart

import 'package:equatable/equatable.dart';

enum CopilotStatus { initial, checking, ready, generating, failure }

class CopilotState extends Equatable {
  final CopilotStatus status;
  final bool isOllamaRunning;
  final String prompt;
  final String generatedText;
  final String? errorMessage;

  const CopilotState({
    this.status = CopilotStatus.initial,
    this.isOllamaRunning = false,
    this.prompt = '',
    this.generatedText = '',
    this.errorMessage,
  });

  CopilotState copyWith({
    CopilotStatus? status,
    bool? isOllamaRunning,
    String? prompt,
    String? generatedText,
    String? errorMessage,
  }) {
    return CopilotState(
      status: status ?? this.status,
      isOllamaRunning: isOllamaRunning ?? this.isOllamaRunning,
      prompt: prompt ?? this.prompt,
      generatedText: generatedText ?? this.generatedText,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        status,
        isOllamaRunning,
        prompt,
        generatedText,
        errorMessage,
      ];
}