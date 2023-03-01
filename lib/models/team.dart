import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/role.dart';

class Team implements Organizer {
  String _id;
  String _name;
  String? _avatarUrl;
  String? description;
  List<Role> roles;

  Team(
    this._id,
    this._name,
    this._avatarUrl, {
    this.description,
    this.roles = const [],
  });

  @override
  String get id {
    return _id;
  }

  set id(String id) {
    _id = id;
  }

  @override
  String get name {
    return _name;
  }

  set name(String name) {
    _name = name;
  }

  @override
  String? get avatarUrl {
    return _avatarUrl;
  }

  set avatarUrl(String? avatarUrl) {
    _avatarUrl = avatarUrl;
  }
}
