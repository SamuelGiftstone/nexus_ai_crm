import 'package:equatable/equatable.dart';

/// Base class for all domain layer failures in Nexus AI CRM.
abstract class Failure extends Equatable {
  final String message;
  final String? code;

  const Failure({
    required this.message,
    this.code,
  });

  @override
  List<Object?> get props => [message, code];
}

// =============================================================================
// DATABASE & STORAGE FAILURES (Drift / Isar / SQLite)
// =============================================================================

class DatabaseFailure extends Failure {
  const DatabaseFailure({
    super.message = 'A local database error occurred while persisting data.',
    super.code = 'DB_ERROR',
  });
}

class RecordNotFoundFailure extends Failure {
  const RecordNotFoundFailure({
    super.message = 'The requested entity could not be found in local storage.',
    super.code = 'NOT_FOUND',
  });
}

class DuplicateRecordFailure extends Failure {
  const DuplicateRecordFailure({
    super.message = 'A record with this unique identifier or key already exists.',
    super.code = 'DUPLICATE_RECORD',
  });
}

// =============================================================================
// LOCAL AI & OLLAMA FAILURES (Gemma 3B Daemon)
// =============================================================================

class OllamaServiceFailure extends Failure {
  const OllamaServiceFailure({
    super.message = 'Failed to communicate with local Ollama engine. Ensure the daemon is running.',
    super.code = 'OLLAMA_UNAVAILABLE',
  });
}

class ModelNotReadyFailure extends Failure {
  final String modelName;

  ModelNotReadyFailure({
    required this.modelName,
    String? code = 'MODEL_NOT_READY',
  }) : super(
          message: 'The AI model "$modelName" is not pulled or loaded in Ollama.',
          code: code,
        );
}

class ContextLimitExceededFailure extends Failure {
  const ContextLimitExceededFailure({
    super.message = 'The provided CRM context exceeds Gemma token capacity.',
    super.code = 'CONTEXT_OVERFLOW',
  });
}

// =============================================================================
// INPUT & VALIDATION FAILURES
// =============================================================================

class ValidationFailure extends Failure {
  final Map<String, String>? fieldErrors;

  const ValidationFailure({
    super.message = 'One or more fields contained invalid or missing inputs.',
    super.code = 'VALIDATION_ERROR',
    this.fieldErrors,
  });

  @override
  List<Object?> get props => [message, code, fieldErrors];
}

class DuplicateDetectionFailure extends Failure {
  const DuplicateDetectionFailure({
    super.message = 'Failed during fuzzy duplicate scan computation.',
    super.code = 'DUPLICATE_SCAN_FAILED',
  });
}

// =============================================================================
// GENERIC / UNEXPECTED FAILURES
// =============================================================================
class ServerFailure extends Failure {
  const ServerFailure({
    super.message = 'A server error occurred. Please try again.',
    super.code = 'SERVER_ERROR',
  });
}

class UnexpectedFailure extends Failure {
  final Object? error;

  UnexpectedFailure({
    String? message,
    super.code = 'UNEXPECTED_ERROR',
    this.error,
  }) : super(
          message: message ?? 'An unexpected system error occurred: ${error ?? "Unknown"}',
        );

  @override
  List<Object?> get props => [message, code, error];
}