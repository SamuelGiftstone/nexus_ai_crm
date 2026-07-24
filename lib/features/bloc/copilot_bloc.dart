// lib/features/copilot/bloc/copilot_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/services/ollama_service.dart';
import 'copilot_event.dart';
import 'copilot_state.dart';

class CopilotBloc extends Bloc<CopilotEvent, CopilotState> {
  final OllamaService _ollamaService;

  CopilotBloc({required OllamaService ollamaService})
      : _ollamaService = ollamaService,
        super(const CopilotState()) {
    on<CopilotCheckAvailability>(_onCheckAvailability);
    on<CopilotSubmitPrompt>(_onSubmitPrompt);
    on<CopilotClearResponse>(_onClearResponse);
  }

  Future<void> _onCheckAvailability(
    CopilotCheckAvailability event,
    Emitter<CopilotState> emit,
  ) async {
    emit(state.copyWith(status: CopilotStatus.checking));
    final isAvailable = await _ollamaService.isAvailable();
    emit(state.copyWith(
      status: isAvailable ? CopilotStatus.ready : CopilotStatus.failure,
      isOllamaRunning: isAvailable,
      errorMessage: isAvailable ? null : 'Local Ollama service (Gemma) is offline.',
    ));
  }

  Future<void> _onSubmitPrompt(
    CopilotSubmitPrompt event,
    Emitter<CopilotState> emit,
  ) async {
    if (event.prompt.trim().isEmpty) return;

    emit(state.copyWith(
      status: CopilotStatus.generating,
      prompt: event.prompt,
      generatedText: '',
    ));

    try {
      final responseStream = _ollamaService.generateStream(
        prompt: event.prompt,
        systemPrompt: event.systemPrompt ??
            'You are an enterprise CRM AI assistant called Gemma. Keep responses structured, concise, and professional.',
      );

      var accumulator = '';
      await for (final chunk in responseStream) {
        accumulator += chunk;
        emit(state.copyWith(
          status: CopilotStatus.generating,
          generatedText: accumulator,
        ));
      }

      emit(state.copyWith(status: CopilotStatus.ready));
    } catch (e) {
      emit(state.copyWith(
        status: CopilotStatus.failure,
        errorMessage: e.toString(),
      ));
    }
  }

  void _onClearResponse(
    CopilotClearResponse event,
    Emitter<CopilotState> emit,
  ) {
    emit(state.copyWith(
      prompt: '',
      generatedText: '',
      status: CopilotStatus.ready,
    ));
  }
}