import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/organization.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/organizations.dart';

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
    final List<Organization> organizationList = [];

    (widget.account as User).participations.forEach((key, value) async {
      final Organization? organization =
          Provider.of<Organizations>(context).findOrganizationById(key);
      if (organization != null) {
        organizationList.add(organization);
      }
    });

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ...organizationList.map(
            (organization) => TeamCard(team: organization, role: ''),
          ),
        ],
      ),
    );
  }
}
