import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/role.dart';

class Team implements Organizer {
  final String _id;
  final String _name;
  final String? _avatarUrl;
  final List<Role> teamRoles;

  Team(
    this._id,
    this._name,
    this._avatarUrl, {
    this.teamRoles = const [],
  });

  String get title {
    return name;
  }

  bool get isManager {
    return false;
  }

  @override
  String get id {
    return _id;
  }

  @override
  String get name {
    return _name;
  }

  @override
  String? get avatarUrl {
    return _avatarUrl;
  }
}
