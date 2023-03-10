// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gd_club_app/db_connectors/memberships_connector.dart';
import 'package:gd_club_app/models/membership.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:uuid/uuid.dart';

class TeamsConnector {
  static final db = FirebaseFirestore.instance;

  static Future<List<Team>> getTeams() async {
    final fetchedTeams = await db.collection('teams').get();

    final List<Team> teams = [];

    for (final team in fetchedTeams.docs) {
      final teamData = team.data();

      final fetchedRoles =
          await db.collection('teams').doc(team.id).collection('roles').get();

      final List<Role> roles = [];

      for (final role in fetchedRoles.docs) {
        final roleData = role.data();

        roles.add(
          Role(
            id: role.id,
            teamId: team.id,
            title: roleData['title'] as String,
            isManager: roleData['isManager'] as bool,
            isOwner: roleData['isOwner'] as bool,
          ),
        );
      }

      teams.add(
        Team(
          team.id,
          teamData['name'] as String,
          teamData['avatarUrl'] as String?,
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
    final teamData = await db.collection('teams').add({
      'name': team.name,
      'description': team.description,
      'avatarUrl': url,
      '_createdAt': Timestamp.now(),
    });

    team.id = teamData.id;

    // Add owner role and member role to the team
    final Role ownerRole = await addRoleToTeam(
      team.id,
      Role(
        id: null,
        teamId: team.id,
        title: 'Người sở hữu',
        isManager: true,
        isOwner: true,
      ),
    );

    final Role memberRole = await addRoleToTeam(
      team.id,
      Role(
        id: null,
        teamId: team.id,
        title: 'Thành viên',
        isManager: false,
        isOwner: false,
      ),
    );

    team.roles = [ownerRole, memberRole];

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
    // Delete all membership to deleting team
    final memberships = await FirebaseFirestore.instance
        .collection('memberships')
        .where('teamId', isEqualTo: teamId)
        .get();

    for (final membership in memberships.docs) {
      await membership.reference.delete();
    }

    // Delete team
    await db.collection('teams').doc(teamId).delete();
  }
}
