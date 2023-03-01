// ignore_for_file: use_setters_to_change_properties

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/membership.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/providers/teams.dart';

class Memberships with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Membership> _list = [];
  late Teams? _teamsProvider;

  Memberships(this._teamsProvider, this._list);

  void update(Teams teamsProvider) {
    _teamsProvider = teamsProvider;
  }

  Map<String, List<Role>> getMembershipsOfAUser({
    required String userId,
  }) {
    final Map<String, List<Role>> membershipMap = {};

    for (final membership in _list) {
      if (membership.memberId == userId) {
        if (membershipMap.containsKey(membership.teamId)) {
          membershipMap[membership.teamId]!.add(
            membership.role,
          );
        } else {
          membershipMap[membership.teamId] = [
            membership.role,
          ];
        }
      }
    }
    return membershipMap;
  }

  bool isUserManagerOfATeam(String userId, String teamId) {
    bool result = false;

    for (final membership in _list) {
      if (membership.memberId == userId &&
          membership.teamId == teamId &&
          membership.role.isManager) {
        result = true;
      }
    }

    return result;
  }

  Map<String, List<Role>> getMemberListOfATeam(String teamId) {
    final Map<String, List<Role>> memberMap = {};

    for (final membership in _list) {
      if (membership.teamId == teamId) {
        if (memberMap.containsKey(membership.teamId)) {
          memberMap[membership.memberId]!.add(
            membership.role,
          );
        } else {
          memberMap[membership.memberId] = [
            membership.role,
          ];
        }
      }
    }

    return memberMap;
  }

  Future<void> fetchMemberships() async {
    final membershipsData = await db.collection('memberships').get();

    final List<Membership> membershipList = [];

    for (final membership in membershipsData.docs) {
      final membershipData = membership.data();

      final Role role = _teamsProvider!
          .findTeamById(membershipData['teamId'] as String)!
          .roles
          .firstWhere((role) => role.id == membershipData['roleId'] as String);

      membershipList.add(
        Membership(
          memberId: membershipData['memberId'] as String,
          teamId: membershipData['teamId'] as String,
          role: role,
        ),
      );
    }

    _list = [...membershipList];

    notifyListeners();
  }

  Future<void> addMembership(Membership membership) async {
    await db.collection('memberships').add({
      'memberId': membership.memberId,
      'teamId': membership.teamId,
      'roleId': membership.role.id,
    });

    _list.insert(0, membership);

    notifyListeners();
  }
}
