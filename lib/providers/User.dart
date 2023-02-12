import 'package:gd_club_app/providers/account.dart';
import 'package:gd_club_app/providers/role.dart';

class User extends Account {
  List<Role> roles;

  User({
    required super.id,
    required super.email,
    required super.name,
    super.avatarUrl,
    this.roles = const [],
  });
}
