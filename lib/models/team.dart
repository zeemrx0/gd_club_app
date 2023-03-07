import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/role.dart';

class Team implements Organizer {
  @override
  String id;
  @override
  String name;
  @override
  String? avatarUrl;
  String? description;
  List<Role> roles;

  Team(
    this.id,
    this.name,
    this.avatarUrl, {
    this.description,
    this.roles = const [],
  });
}
