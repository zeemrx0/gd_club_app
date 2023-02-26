import 'package:gd_club_app/models/account.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/role.dart';

class User extends Account implements Organizer {
  // User can participate in many organizations
  // And in charge of many roles in each organization
  Map<String, List<Role>> participations;

  User({
    required super.id,
    required super.email,
    required super.name,
    super.avatarUrl,
    required super.systemRole,
    this.participations = const {},
  });
}
