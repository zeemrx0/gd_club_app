import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/participation.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/participations.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:provider/provider.dart';

class User extends Account implements Organizer {
  User({
    required super.id,
    required super.email,
    required super.name,
    super.avatarUrl,
    required super.systemRole,
  });

  Future<void> createATeam(Team team, File? image, BuildContext context) async {
    team =
        await Provider.of<Teams>(context, listen: false).addTeam(team, image);

    Role role = await Provider.of<Teams>(context, listen: false).addRoleToTeam(
      team.id,
      Role(
        id: null,
        title: 'Thành viên',
        isManager: false,
      ),
    );

    await Provider.of<Participations>(context, listen: false).addParticipation(
      Participation(memberId: id, teamId: team.id, role: role),
    );
  }
}
