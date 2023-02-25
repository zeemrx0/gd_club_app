import 'package:flutter/material.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/providers/organizations.dart';
import 'package:gd_club_app/providers/users.dart';

class Organizers with ChangeNotifier {
  Users? _usersProvider;
  Organizations? _organizationsProvider;

  Organizers(
    this._usersProvider,
    this._organizationsProvider,
  );

  void update(
    Users usersProvider,
    Organizations organizationsProvider,
  ) {
    _usersProvider = usersProvider;
    _organizationsProvider = organizationsProvider;

    notifyListeners();
  }

  Organizer? findOrganizerById(String organizerId) {
    if (_usersProvider == null || _organizationsProvider == null) {
      return null;
    }

    return _usersProvider!.findUserById(organizerId) ??
        _organizationsProvider!.findOrganizationById(organizerId);
  }
}
