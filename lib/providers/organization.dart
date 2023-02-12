import 'package:gd_club_app/providers/account.dart';
import 'package:gd_club_app/providers/role.dart';

class Organization implements Role {
  final String name;
  final String avatarUrl;
  final List<Role> organizationRoles;

  Organization({
    required this.name,
    required this.avatarUrl,
    this.organizationRoles = const [],
  });

  @override
  String get title {
    return name;
  }
}
