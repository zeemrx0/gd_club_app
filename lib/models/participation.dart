import 'package:gd_club_app/models/role.dart';

class Participation {
  String memberId;
  String teamId;
  Role role;

  Participation({
    required this.memberId,
    required this.teamId,
    required this.role,
  });
}
