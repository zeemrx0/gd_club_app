import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/participations.dart';
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

    final participations = Provider.of<Participations>(context)
        .getParticipationsOfAUser(userId: widget.account.id);

    participations.forEach((key, value) async {
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
            (team) => TeamCard(team: team, role: ''),
          ),
        ],
      ),
    );
  }
}
