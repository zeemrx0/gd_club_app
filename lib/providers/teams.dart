// ignore_for_file: use_setters_to_change_properties
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:gd_club_app/db_connectors/teams_connector.dart';

import 'package:gd_club_app/models/team.dart';

class Teams with ChangeNotifier {
  List<Team> _list = [];

  Teams();

  List<Team> get list {
    return [..._list];
  }

  Team? findTeamById(String teamId) {
    final index = _list.indexWhere((team) => team.id == teamId);

    return index >= 0 ? _list[index] : null;
  }

  Future<void> fetchTeams() async {
    final List<Team> teams = await TeamsConnector.getTeams();

    _list = [...teams];

    notifyListeners();
  }

  Future<Team> createTeam(
      Team team, File? teamAvatarFile, String ownerId) async {
    team = await TeamsConnector.createTeam(team, teamAvatarFile, ownerId);

    _list.insert(0, team);

    notifyListeners();

    return team;
  }

  Future<void> deleteTeam({required String teamId}) async {
    TeamsConnector.deleteTeam(teamId: teamId);

    _list.removeWhere((team) => team.id == teamId);

    notifyListeners();
  }
}
