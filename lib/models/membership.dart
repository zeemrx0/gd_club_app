import 'package:gd_club_app/models/role.dart';

class Membership {
  String memberId;
  String teamId;
  Role role;

  Membership({
    required this.memberId,
    required this.teamId,
    required this.role,
  });
}
