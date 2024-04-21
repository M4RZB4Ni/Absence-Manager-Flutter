class LeaveRequestsContainerEntity {
  final String message;
  final List<LeaveRequestEntity> payload;

  LeaveRequestsContainerEntity({
    required this.message,
    required this.payload,
  });
}

class LeaveRequestEntity {
  final int? admitterId;
  final String? admitterNote;
  final DateTime? confirmedAt;
  final DateTime createdAt;
  final int crewId;
  final DateTime endDate;
  final int id;
  final String? memberNote;
  final DateTime? rejectedAt;
  final DateTime startDate;
  final String type;
  final int userId;

  LeaveRequestEntity({
    this.admitterId,
    this.admitterNote,
    this.confirmedAt,
    required this.createdAt,
    required this.crewId,
    required this.endDate,
    required this.id,
    this.memberNote,
    this.rejectedAt,
    required this.startDate,
    required this.type,
    required this.userId,
  });
}