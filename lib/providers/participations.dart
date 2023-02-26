import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/models/role.dart';

class Participations {
  final db = FirebaseFirestore.instance;

  Future<Map<String, List<Role>>> getParticipationsOfAUser(
      {required String userId}) async {
    final participations = await db
        .collection('participations')
        .where(
          'memberId',
          isEqualTo: userId,
        )
        .orderBy('teamId')
        .get();

    final Map<String, List<Role>> participationMap = {};

    for (final participation in participations.docs) {
      final teamId = participation.data()['teamId'] as String;
      final role = await db
          .collection('teams')
          .doc(teamId)
          .collection('roles')
          .doc(participation.data()['roleId'] as String)
          .get();

      if (participationMap.containsKey(teamId)) {
        participationMap[teamId]!.add(
          Role(role.data()!['title'] as String,
              role.data()!['isManager'] as bool),
        );
      } else {
        participationMap[teamId] = [
          Role(role.data()!['title'] as String,
              role.data()!['isManager'] as bool),
        ];
      }
    }
    return participationMap;
  }
}
