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
        .orderBy('organizationId')
        .get();

    final Map<String, List<Role>> participationMap = {};

    for (final participation in participations.docs) {
      final organizationId = participation.data()['organizationId'] as String;
      final role = await db
          .collection('organizations')
          .doc(organizationId)
          .collection('roles')
          .doc(participation.data()['roleId'] as String)
          .get();

      if (participationMap.containsKey(organizationId)) {
        participationMap[organizationId]!.add(
          Role(role.data()!['title'] as String,
              role.data()!['isManager'] as bool),
        );
      } else {
        participationMap[organizationId] = [
          Role(role.data()!['title'] as String,
              role.data()!['isManager'] as bool),
        ];
      }
    }
    return participationMap;
  }
}
