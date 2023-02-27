// ignore_for_file: use_setters_to_change_properties

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/participation.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/providers/teams.dart';

class Participations with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Participation> _list = [];
  Teams? _teamsProvider;

  Participations(this._teamsProvider, this._list);

  void update(Teams teamsProvider) {
    _teamsProvider = teamsProvider;
  }

  Map<String, List<Role>> getParticipationsOfAUser({
    required String userId,
  }) {
    final Map<String, List<Role>> participationMap = {};

    for (final participation in _list) {
      if (participationMap.containsKey(participation.teamId)) {
        participationMap[participation.teamId]!.add(
          participation.role,
        );
      } else {
        participationMap[participation.teamId] = [
          participation.role,
        ];
      }
    }
    return participationMap;
  }

  Future<void> fetchParticipations() async {
    final participationsData = await db.collection('participations').get();

    final List<Participation> participationList = [];

    for (final participation in participationsData.docs) {
      final participationData = participation.data();

      final Role role = _teamsProvider!
          .findTeamById(participationData['teamId'] as String)!
          .roles
          .firstWhere(
              (role) => role.id == participationData['roleId'] as String);

      participationList.add(
        Participation(
          memberId: participationData['memberId'] as String,
          teamId: participationData['teamId'] as String,
          role: role,
        ),
      );
    }

    _list = [...participationList];

    notifyListeners();
  }

  Future<void> addParticipation(Participation participation) async {
    await db.collection('participations').add({
      'memberId': participation.memberId,
      'teamId': participation.teamId,
      'roleId': participation.role.id,
    });

    _list.insert(0, participation);

    notifyListeners();
  }
}
