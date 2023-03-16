import 'dart:io';
import 'package:flutter/material.dart';
import 'package:gd_club_app/db_connectors/memberships_connector.dart';
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

    final rolesData = team.roles;

    final ownerRoleData = rolesData.firstWhere((role) => role.isOwner == true);

    final ownerRole = Role(
      id: ownerRoleData.id as String,
      teamId: team.id,
      title: ownerRoleData.title as String,
      isManager: ownerRoleData.isManager as bool,
      isOwner: ownerRoleData.isOwner as bool,
    );

    await Provider.of<Memberships>(context, listen: false).addMembership(
        Membership(memberId: id, teamId: team.id, role: ownerRole));
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

  Future<void> leaveATeam(String teamId, BuildContext context) async {
    await Provider.of<Memberships>(context, listen: false).removeMembership(
      memberId: id,
      teamId: teamId,
    );
  }

  Future<void> deleteATeam(BuildContext context,
      {required String teamId}) async {
    await Provider.of<Teams>(context, listen: false).deleteTeam(teamId: teamId);
  }
}
