// ignore_for_file: avoid_classes_with_only_static_members

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/models/registration.dart';

class RegistrationsConnector {
  static final db = FirebaseFirestore.instance;

  static Future<List<Registration>> getRegistrationsOfAnEvent({
    required String eventId,
  }) async {
    final fetchedRegistrations = await db
        .collection('registrations')
        .where('eventId', isEqualTo: eventId)
        .get();

    final List<Registration> registrations = [];

    for (final registration in fetchedRegistrations.docs) {
      final registrationData = registration.data();

      registrations.add(
        Registration(
          eventId: registrationData['eventId'] as String,
          registrantId: registrationData['registrantId'] as String,
        ),
      );
    }

    return registrations;
  }

  static Future<Registration> addRegistration({
    required String eventId,
    required String registrantId,
  }) async {
    await FirebaseFirestore.instance.collection('registrations').add(
      {
        'eventId': eventId,
        'registrantId': registrantId,
      },
    );

    return Registration(eventId: eventId, registrantId: registrantId);
  }

  static Future<void> removeRegistration({
    required String eventId,
    required String registrantId,
  }) async {
    final registrations = await FirebaseFirestore.instance
        .collection('registrations')
        .where(
          'registrantId',
          isEqualTo: registrantId,
        )
        .where('eventId', isEqualTo: eventId)
        .get();

    for (final registration in registrations.docs) {
      await registration.reference.delete();
    }
  }
}
