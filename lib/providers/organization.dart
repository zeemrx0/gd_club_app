import 'package:gd_club_app/providers/account.dart';
import 'package:gd_club_app/providers/role.dart';

class Organization extends Account implements Role {
  final organizationRoles;

  Organization({
    required super.id,
    required super.email,
    required super.name,
    super.imageUrl,
    this.organizationRoles = const [],
  });

  @override
  String get title {
    return name;
  }
}
