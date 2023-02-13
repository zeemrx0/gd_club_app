import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/registration.dart';

class Registrations with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Registration> _list = [];

  Future<void> fetchRegistrations() async {
    final registrationsData = await db.collection('registrations').get();

    final List<Registration> registrationList = [];

    for (final registration in registrationsData.docs) {
      registrationList.add(
        Registration(
          eventId: registration.data()['eventId'] as String,
          registrantId: registration.data()['registrantId'] as String,
        ),
      );
    }

    _list = [...registrationList];

    notifyListeners();
  }

  List<Registration> getAllRegistrations() {
    return [..._list];
  }

  List<Registration> getAllRegistrationsOfAUser(String registrantId) {
    return _list
        .where(
          (registration) => registration.registrantId == registrantId,
        )
        .toList();
  }

  Future<void> addRegistration(
      {required String eventId, required String registrantId}) async {
    await FirebaseFirestore.instance.collection('registrations').add(
      {
        'eventId': eventId,
        'registrantId': registrantId,
      },
    );
  }

  Future<void> removeRegistration(
      {required String eventId, required String registrantId}) async {
    final registrations = await FirebaseFirestore.instance
        .collection('registrations')
        .where(
          'registrantId',
          isEqualTo: registrantId,
        )
        .where('eventId', isEqualTo: eventId)
        .get();

    for (final registration in registrations.docs) {
      registration.reference.delete();
    }
  }
}
