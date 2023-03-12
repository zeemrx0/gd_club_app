// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gd_club_app/db_connectors/memberships_connector.dart';
import 'package:gd_club_app/db_connectors/rest_client.dart';
import 'package:gd_club_app/models/membership.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:uuid/uuid.dart';

class TeamsConnector {
  static final db = FirebaseFirestore.instance;

  static Future<List<Team>> getTeams() async {
    final fetchedTeams = await RestClient().get('/teams') as List<dynamic>;

    final List<Team> teams = [];

    for (final team in fetchedTeams) {
      final List<Role> roles = [];

      for (final role in team['roles'] as List<dynamic>) {
        roles.add(
          Role(
            id: role['_id'] as String,
            teamId: team['_id'] as String,
            title: role['title'] as String,
            isManager: role['isManager'] as bool,
            isOwner: role['isOwner'] as bool,
          ),
        );
      }

      teams.add(
        Team(
          team['_id'] as String,
          team['name'] as String,
          team['avatarUrl'] as String?,
          roles: roles,
        ),
      );
    }

    return teams.toList();
  }

  static Future<Team> createTeam(
      Team team, File? teamAvatarFile, String ownerId) async {
    // Prepare avatar image
    final String imageId = const Uuid().v4();

    String? url;

    if (teamAvatarFile != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('team_images')
          .child('$imageId.jpg');

      await ref.putFile(teamAvatarFile);
      url = await ref.getDownloadURL();
    }

    // Create team
    final teamData = await RestClient().post(
      '/teams',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'name': team.name,
          'description': team.description,
          'avatarUrl': url,
        },
      ),
    );

    team.id = teamData['_id'] as String;

    final rolesData = teamData['roles'] as List<dynamic>;

    final ownerRoleData =
        rolesData.firstWhere((role) => (role['isOwner'] as bool) == true);

    final ownerRole = Role(
      id: ownerRoleData['_id'] as String,
      teamId: team.id,
      title: ownerRoleData['title'] as String,
      isManager: ownerRoleData['isManager'] as bool,
      isOwner: ownerRoleData['isOwner'] as bool,
    );

    // Set user as owner
    await MembershipsConnector.addMembership(
      Membership(memberId: ownerId, teamId: team.id, role: ownerRole),
    );

    return team;
  }

  static Future<Role?> getRoleOfATeam({
    required String teamId,
    required String roleId,
  }) async {
    final fetchedRole = await db
        .collection('teams')
        .doc(teamId)
        .collection('roles')
        .doc(roleId)
        .get();

    final roleData = fetchedRole.data();

    return roleData != null
        ? Role(
            id: fetchedRole.id,
            teamId: teamId,
            title: roleData['title'] as String,
            isManager: roleData['isManager'] as bool,
            isOwner: roleData['isOwner'] as bool,
          )
        : null;
  }

  static Future<Role> addRoleToTeam(String teamId, Role role) async {
    final roleData =
        await db.collection('teams').doc(teamId).collection('roles').add({
      'title': role.title,
      'isManager': role.isManager,
      'isOwner': role.isManager,
      '_createdAt': Timestamp.now(),
    });

    role.id = roleData.id;

    return role;
  }

  static Future<void> deleteTeam({required String teamId}) async {
    await RestClient().delete('/teams/$teamId');
  }
}
