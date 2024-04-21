import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/entities/crew/crew_entity.dart';

part 'crew_member_model.freezed.dart';
part 'crew_member_model.g.dart';

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

  CrewMemberEntity toEntity() {
    return CrewMemberEntity(
      crewId: crewId,
      id: id,
      image: image,
      name: name,
      userId: userId,
    );
  }

}

@freezed
class CrewMembersContainer with _$CrewMembersContainer {
  const factory CrewMembersContainer({
    required String message,
    required List<CrewMember> payload,
  }) = _CrewMembersContainer;

  factory CrewMembersContainer.fromJson(Map<String, dynamic> json) => _$CrewMembersContainerFromJson(json);

  CrewMembersContainerEntity toEntity() {
    return CrewMembersContainerEntity(
      message: message,
      payload: payload.map((crewMember) => crewMember.toEntity()).toList(),
    );
  }

}
