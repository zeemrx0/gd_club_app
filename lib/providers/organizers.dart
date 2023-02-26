import 'package:flutter/material.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/providers/teams.dart';
import 'package:gd_club_app/providers/users.dart';

class Organizers with ChangeNotifier {
  Users? _usersProvider;
  Teams? _teamsProvider;

  Organizers(
    this._usersProvider,
    this._teamsProvider,
  );

  void update(
    Users usersProvider,
    Teams teamsProvider,
  ) {
    _usersProvider = usersProvider;
    _teamsProvider = teamsProvider;

    notifyListeners();
  }

  Organizer? findOrganizerById(String organizerId) {
    if (_usersProvider == null || _teamsProvider == null) {
      return null;
    }

    return _usersProvider!.findUserById(organizerId) ??
        _teamsProvider!.findTeamById(organizerId);
  }
}
