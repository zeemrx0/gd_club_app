import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/membership.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/role.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/providers/events.dart';
import 'package:gd_club_app/providers/memberships.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:provider/provider.dart';

class User implements Organizer {
  @override
  String id;
  String email;
  @override
  String name;
  @override
  String? avatarUrl;
  String systemRole;

  User({
    required this.id,
    required this.email,
    required this.name,
    this.avatarUrl,
    required this.systemRole,
  });

  Future<void> createATeam(Team team, File? image, BuildContext context) async {
    team = await Provider.of<Teams>(context, listen: false)
        .createTeam(team, image, id);
  }

  Future<void> joinATeam(String teamId, BuildContext context) async {
    final List<Role> roleList =
        Provider.of<Teams>(context, listen: false).findTeamById(teamId)!.roles;

    final Role memberRole =
        roleList[roleList.indexWhere((role) => role.title == 'Thành viên')];

    await Provider.of<Memberships>(context, listen: false).addMembership(
      Membership(memberId: id, teamId: teamId, role: memberRole),
    );
  }

  Future<void> toggleRegisteredAnEvent(
      String eventId, BuildContext context) async {
    await Provider.of<Events>(context, listen: false)
        .toggleRegisteredAnEvent(eventId, context);
  }
}
