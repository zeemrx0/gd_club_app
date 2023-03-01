import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/memberships.dart';
import 'package:gd_club_app/providers/teams.dart';

import 'package:gd_club_app/widgets/teams/team_card.dart';
import 'package:provider/provider.dart';

class TeamList extends StatefulWidget {
  final Account account;
  const TeamList(this.account, {super.key});

  @override
  State<TeamList> createState() => _TeamListState();
}

class _TeamListState extends State<TeamList> {
  @override
  Widget build(BuildContext context) {
    final List<Team> teamList = [];

    final memberships = Provider.of<Memberships>(context)
        .getMembershipsOfAUser(userId: widget.account.id);

    memberships.forEach((key, value) async {
      final Team? team = Provider.of<Teams>(context).findTeamById(key);
      if (team != null) {
        teamList.add(team);
      }
    });

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...teamList.map(
            (team) => Container(
              margin: const EdgeInsets.only(
                bottom: 8,
              ),
              child: TeamCard(team: team, role: ''),
            ),
          ),
        ],
      ),
    );
  }
}
