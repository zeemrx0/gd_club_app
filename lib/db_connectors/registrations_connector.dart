// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/db_connectors/rest_client.dart';
import 'package:gd_club_app/models/registration.dart';

class RegistrationsConnector {
  static final db = FirebaseFirestore.instance;

  // static Future<List<Registration>> getRegistrationsOfAnEvent({
  //   required String eventId,
  // }) async {
  //   final fetchedRegistrations = await db
  //       .collection('registrations')
  //       .where('eventId', isEqualTo: eventId)
  //       .get();

  //   final List<Registration> registrations = [];

  //   for (final registration in fetchedRegistrations.docs) {
  //     final registrationData = registration.data();

  //     registrations.add(
  //       Registration(
  //         eventId: registrationData['eventId'] as String,
  //         registrantId: registrationData['registrantId'] as String,
  //       ),
  //     );
  //   }

  //   return registrations;
  // }

  static Future<Registration> addRegistration({
    required String eventId,
    required String registrantId,
  }) async {
    await RestClient().post(
      '/registrations',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'event': eventId,
          'registrant': registrantId,
        },
      ),
    );

    return Registration(eventId: eventId, registrantId: registrantId);
  }

  static Future<void> removeRegistration({
    required String eventId,
    required String registrantId,
  }) async {
    await RestClient().delete(
      '/registrations',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'event': eventId,
          'registrant': registrantId,
        },
      ),
    );
  }
}
