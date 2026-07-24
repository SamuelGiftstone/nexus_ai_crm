// lib/features/followups/domain/followup_model.dart

enum FollowupType { email, call, meeting, task }

enum FollowupPriority { low, medium, high, urgent }

enum FollowupStatus { pending, completed, cancelled, overdue }

class FollowupModel {
  final int? id;
  final int contactId;
  final String contactName;
  final String title;
  final String? note;
  final FollowupType type;
  final FollowupPriority priority;
  final FollowupStatus status;
  final DateTime scheduledAt;
  final DateTime? completedAt;

  const FollowupModel({
    this.id,
    required this.contactId,
    required this.contactName,
    required this.title,
    this.note,
    required this.type,
    required this.priority,
    required this.status,
    required this.scheduledAt,
    this.completedAt,
  });

  bool get isOverdue =>
      status == FollowupStatus.pending && scheduledAt.isBefore(DateTime.now());

  FollowupModel copyWith({
    int? id,
    int? contactId,
    String? contactName,
    String? title,
    String? note,
    FollowupType? type,
    FollowupPriority? priority,
    FollowupStatus? status,
    DateTime? scheduledAt,
    DateTime? completedAt,
  }) {
    return FollowupModel(
      id: id ?? this.id,
      contactId: contactId ?? this.contactId,
      contactName: contactName ?? this.contactName,
      title: title ?? this.title,
      note: note ?? this.note,
      type: type ?? this.type,
      priority: priority ?? this.priority,
      status: status ?? this.status,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      completedAt: completedAt ?? this.completedAt,
    );
  }
}