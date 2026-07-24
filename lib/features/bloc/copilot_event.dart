// lib/features/copilot/bloc/copilot_event.dart

import 'package:equatable/equatable.dart';

abstract class CopilotEvent extends Equatable {
  const CopilotEvent();

  @override
  List<Object?> get props => [];
}

/// Event triggered when opening Copilot view to check local Ollama availability
class CopilotCheckAvailability extends CopilotEvent {}

/// Triggered when the user submits a text prompt
class CopilotSubmitPrompt extends CopilotEvent {
  final String prompt;
  final String? systemPrompt;

  const CopilotSubmitPrompt({
    required this.prompt,
    this.systemPrompt,
  });

  @override
  List<Object?> get props => [prompt, systemPrompt];
}

/// Reset prompt and generation state
class CopilotClearResponse extends CopilotEvent {}