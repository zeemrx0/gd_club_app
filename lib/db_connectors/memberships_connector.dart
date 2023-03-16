// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:gd_club_app/db_connectors/rest_client.dart';
import 'package:gd_club_app/models/membership.dart';
import 'package:gd_club_app/models/role.dart';

class MembershipsConnector {
  static Future<List<Membership>> getMemberships() async {
    final fetchedMemberships =
        await RestClient().get('/memberships') as List<dynamic>;

    final List<Membership> memberships = [];

    for (final membership in fetchedMemberships) {
      final String teamId = membership['team'] as String;
      final String memberId = membership['member'] as String;
      final roleData = membership['role'] as dynamic;

      final Role role = Role(
        id: roleData['_id'] as String,
        teamId: teamId,
        title: roleData['title'] as String,
        isManager: roleData['isManager'] as bool,
        isOwner: roleData['isOwner'] as bool,
      );

      memberships.add(
        Membership(
          memberId: memberId,
          teamId: teamId,
          role: role,
        ),
      );
    }

    return memberships;
  }

  static Future<Membership> addMembership(Membership membership) async {
    await RestClient().post(
      '/memberships',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'member': membership.memberId,
          'team': membership.teamId,
          'role': membership.role.id,
        },
      ),
    );

    return membership;
  }

  static Future<void> removeMembership({
    required String memberId,
    required String teamId,
  }) async {
    await RestClient().post(
      '/memberships',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'member': memberId,
          'team': teamId,
        },
      ),
    );
  }
}
