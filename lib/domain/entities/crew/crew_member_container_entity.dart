import '../crew/crew_member_entity.dart';

class CrewMembersContainerEntity {
  final String message;
  final List<CrewMemberEntity> payload;

  CrewMembersContainerEntity({
    required this.message,
    required this.payload,
  });

}