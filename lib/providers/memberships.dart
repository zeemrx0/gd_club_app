// ignore_for_file: use_setters_to_change_properties

import 'package:flutter/material.dart';
import 'package:gd_club_app/db_connectors/memberships_connector.dart';
import 'package:gd_club_app/models/membership.dart';
import 'package:gd_club_app/models/role.dart';

class Memberships with ChangeNotifier {
  List<Membership> _list = [];

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
    final memberships = await MembershipsConnector.getMemberships();

    _list = [...memberships];

    notifyListeners();
  }

  Future<void> addMembership(Membership membership) async {
    membership = await MembershipsConnector.addMembership(membership);

    _list.insert(0, membership);

    notifyListeners();
  }
}
