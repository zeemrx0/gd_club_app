// ignore_for_file: use_setters_to_change_properties

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/memberships.dart';

import 'package:uuid/uuid.dart';

class Teams with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Team> _list = const [];

  Teams();

  List<Team> get list {
    return [..._list];
  }

  Team? findTeamById(String teamId) {
    final index = _list.indexWhere((team) => team.id == teamId);

    return index >= 0 ? _list[index] : null;
  }

  Future<void> fetchTeams() async {
    final teams = await db.collection('teams').get();

    final List<Team> teamList = [];

    for (final team in teams.docs) {
      final teamData = team.data();

      final fetchedRoles =
          await db.collection('teams').doc(team.id).collection('roles').get();

      final List<Role> roles = [];

      for (final role in fetchedRoles.docs) {
        final roleData = role.data();

        roles.add(
          Role(
            id: role.id,
            title: roleData['title'] as String,
            isManager: roleData['isManager'] as bool,
          ),
        );
      }

      teamList.add(
        Team(
          team.id,
          teamData['name'] as String,
          teamData['avatarUrl'] as String?,
          roles: roles,
        ),
      );
    }

    _list = [...teamList];

    notifyListeners();
  }

  Future<Team> addTeam(Team team, File? image) async {
    final String imageId = const Uuid().v4();

    String? url;

    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('team_images')
          .child('$imageId.jpg');

      await ref.putFile(image);
      url = await ref.getDownloadURL();
    }

    final teamData = await db.collection('teams').add({
      'name': team.name,
      'description': team.description,
      'avatarUrl': url,
      '_createdAt': Timestamp.now(),
    });

    team.id = teamData.id;

    _list.insert(0, team);

    notifyListeners();

    return team;
  }

  Future<Role> addRoleToTeam(String teamId, Role role) async {
    final roleData =
        await db.collection('teams').doc(teamId).collection('roles').add({
      'title': role.title,
      'isManager': role.isManager,
      '_createdAt': Timestamp.now(),
    });

    role.id = roleData.id;

    notifyListeners();

    return role;
  }
}
