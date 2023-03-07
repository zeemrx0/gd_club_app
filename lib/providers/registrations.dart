import 'package:flutter/material.dart';
import 'package:gd_club_app/db_connectors/registrations_connector.dart';

class Registrations with ChangeNotifier {
  Future<void> addRegistration({
    required String eventId,
    required String registrantId,
  }) async {
    RegistrationsConnector.addRegistration(
      eventId: eventId,
      registrantId: registrantId,
    );

    notifyListeners();
  }

  Future<void> removeRegistration({
    required String eventId,
    required String registrantId,
  }) async {
    RegistrationsConnector.removeRegistration(
      eventId: eventId,
      registrantId: registrantId,
    );
    notifyListeners();
  }
}
