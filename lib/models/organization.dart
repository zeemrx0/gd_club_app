import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/role.dart';

class Organization implements Organizer {
  final String id;
  final String name;
  final String? avatarUrl;
  final List<Role> organizationRoles;

  Organization({
    required this.id,
    required this.name,
    required this.avatarUrl,
    this.organizationRoles = const [],
  });

  @override
  String get title {
    return name;
  }

  @override
  bool get isManager {
    return false;
  }
}
