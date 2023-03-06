// ignore_for_file: avoid_classes_with_only_static_members

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/db_connectors/teams_connector.dart';
import 'package:gd_club_app/models/membership.dart';
import 'package:gd_club_app/models/role.dart';

class MembershipsConnector {
  static final db = FirebaseFirestore.instance;

  static Future<List<Membership>> getMemberships() async {
    final fetchedMemberships = await db.collection('memberships').get();

    final List<Membership> memberships = [];

    for (final membership in fetchedMemberships.docs) {
      final membershipData = membership.data();

      final String teamId = membershipData['teamId'] as String;
      final String memberId = membershipData['memberId'] as String;
      final String roleId = membershipData['roleId'] as String;

      final Role? role =
          await TeamsConnector.getRoleOfATeam(teamId: teamId, roleId: roleId);

      if (role != null) {
        memberships.add(
          Membership(
            memberId: memberId,
            teamId: teamId,
            role: role,
          ),
        );
      }
    }

    return memberships;
  }

  static Future<Membership> addMembership(Membership membership) async {
    await db.collection('memberships').add({
      'memberId': membership.memberId,
      'teamId': membership.teamId,
      'roleId': membership.role.id,
    });

    return membership;
  }
}
