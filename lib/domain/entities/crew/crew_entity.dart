class CrewMembersContainerEntity {
  final String message;
  final List<CrewMemberEntity> payload;

  CrewMembersContainerEntity({
    required this.message,
    required this.payload,
  });

}

class CrewMemberEntity {
  final int crewId;
  final int id;
  final String image;
  final String name;
  final int userId;

  CrewMemberEntity({
    required this.crewId,
    required this.id,
    required this.image,
    required this.name,
    required this.userId,
  });
}