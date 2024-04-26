/// Represents a container for crew members.
class CrewMembersContainerEntity {
  /// A descriptive message related to the crew members.
  final String message;

  /// A list of individual crew member entities.
  final List<CrewMemberEntity> payload;

  /// Constructs a [CrewMembersContainerEntity].
  ///
  /// - [message]: A descriptive message.
  /// - [payload]: A list of crew member entities.
  CrewMembersContainerEntity({
    required this.message,
    required this.payload,
  });
}

/// Represents an individual crew member.
class CrewMemberEntity {
  /// The ID of the crew associated with the member.
  final int crewId;

  /// The unique ID of the crew member.
  final int id;

  /// The image associated with the crew member.
  final String image;

  /// The name of the crew member.
  final String name;

  /// The ID of the user associated with the crew member.
  final int userId;

  /// Constructs a [CrewMemberEntity].
  ///
  /// - [crewId]: The ID of the crew.
  /// - [id]: The unique ID of the crew member.
  /// - [image]: The image associated with the crew member.
  /// - [name]: The name of the crew member.
  /// - [userId]: The ID of the user associated with the crew member.
  CrewMemberEntity({
    required this.crewId,
    required this.id,
    required this.image,
    required this.name,
    required this.userId,
  });
}
