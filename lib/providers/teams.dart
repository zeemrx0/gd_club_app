import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gd_club_app/models/team.dart';

class Teams with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Team> _list = const [];

  List<Team> get list {
    return [..._list];
  }

  Team? findTeamById(String teamId) {
    final index = _list.indexWhere((team) => team.id == teamId);

    return index >= 0 ? _list[index] : null;
  }

  Future<void> fetchTeams() async {
    final teamsData = await db.collection('teams').get();

    final List<Team> teamList = [];

    for (final team in teamsData.docs) {
      final teamData = team.data();

      teamList.add(
        Team(
          team.id,
          teamData['name'] as String,
          teamData['avatarUrl'] as String,
        ),
      );
    }

    _list = [...teamList];

    notifyListeners();
  }
}
