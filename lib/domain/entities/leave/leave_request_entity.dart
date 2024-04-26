/// Represents a container for leave requests.
class LeaveRequestsContainerEntity {
  /// A descriptive message related to the leave requests.
  final String message;

  /// A list of individual leave request entities.
  final List<LeaveRequestEntity> payload;

  /// Constructs a [LeaveRequestsContainerEntity].
  ///
  /// - [message]: A descriptive message.
  /// - [payload]: A list of leave request entities.
  LeaveRequestsContainerEntity({
    required this.message,
    required this.payload,
  });
}

/// Represents an individual leave request.
class LeaveRequestEntity {
  /// The ID of the admitter (if applicable).
  final int? admitterId;

  /// Additional notes provided by the admitter (if applicable).
  final String? admitterNote;

  /// The date and time when the leave request was confirmed.
  final DateTime? confirmedAt;

  /// The date and time when the leave request was created.
  final DateTime createdAt;

  /// The ID of the crew associated with the leave request.
  final int crewId;

  /// The end date of the leave request.
  final DateTime endDate;

  /// The unique ID of the leave request.
  final int id;

  /// Additional notes provided by the requesting member.
  final String? memberNote;

  /// The date and time when the leave request was rejected (if applicable).
  final DateTime? rejectedAt;

  /// The start date of the leave request.
  final DateTime startDate;

  /// The type of leave (e.g., vacation, sick leave).
  final String type;

  /// The ID of the user who submitted the leave request.
  final int userId;

  /// Constructs a [LeaveRequestEntity].
  ///
  /// - [admitterId]: The ID of the admitter (if applicable).
  /// - [admitterNote]: Additional notes provided by the admitter (if applicable).
  /// - [confirmedAt]: The date and time when the leave request was confirmed.
  /// - [createdAt]: The date and time when the leave request was created.
  /// - [crewId]: The ID of the crew associated with the leave request.
  /// - [endDate]: The end date of the leave request.
  /// - [id]: The unique ID of the leave request.
  /// - [memberNote]: Additional notes provided by the requesting member.
  /// - [rejectedAt]: The date and time when the leave request was rejected (if applicable).
  /// - [startDate]: The start date of the leave request.
  /// - [type]: The type of leave (e.g., vacation, sick leave).
  /// - [userId]: The ID of the user who submitted the leave request.
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
