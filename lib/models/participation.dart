import 'package:gd_club_app/models/role.dart';

class Participation {
  String memberId;
  String organizationId;
  Role role;

  Participation({
    required this.memberId,
    required this.organizationId,
    required this.role,
  });
}
