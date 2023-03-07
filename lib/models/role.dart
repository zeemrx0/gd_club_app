import 'package:gd_club_app/db_connectors/teams_connector.dart';

class Role {
  String? id;
  String teamId;
  String title;
  bool isManager;
  bool isOwner;

  Role({
    required this.id,
    required this.teamId,
    required this.title,
    required this.isManager,
    required this.isOwner,
  });

  Future<Role> addRoleToTeam(Role role) async {
    role = await TeamsConnector.addRoleToTeam(teamId, role);

    return role;
  }
}
