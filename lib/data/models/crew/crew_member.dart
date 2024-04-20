import 'package:freezed_annotation/freezed_annotation.dart';

part 'crew_member.freezed.dart';
part 'crew_member.g.dart';

@freezed
class CrewMember with _$CrewMember {
  const factory CrewMember({
    required int crewId,
    required int id,
    required String image,
    required String name,
    required int userId,
  }) = _CrewMember;

  factory CrewMember.fromJson(Map<String, dynamic> json) => _$CrewMemberFromJson(json);
}

@freezed
class CrewMembersContainer with _$CrewMembersContainer {
  const factory CrewMembersContainer({
    required String message,
    required List<CrewMember> payload,
  }) = _CrewMembersContainer;

  factory CrewMembersContainer.fromJson(Map<String, dynamic> json) => _$CrewMembersContainerFromJson(json);
}
