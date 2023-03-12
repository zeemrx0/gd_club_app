import 'package:flutter/material.dart';
import 'package:gd_club_app/db_connectors/events_connector.dart';

class Registrations with ChangeNotifier {
  Future<void> addRegistration({
    required String eventId,
    required String registrantId,
  }) async {
    EventsConnector.addRegistration(
        eventId: eventId, registrantId: registrantId);

    notifyListeners();
  }

  Future<void> removeRegistration({
    required String eventId,
    required String registrantId,
  }) async {
    EventsConnector.deleteRegistration(
        eventId: eventId, registrantId: registrantId);

    notifyListeners();
  }
}
