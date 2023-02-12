import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/registration.dart';

class Registrations with ChangeNotifier {
  List<Registration> _list = [];

  final db = FirebaseFirestore.instance;

  Future<void> fetchRegistrations() async {
    final registrationsData = await db.collection('registrations').get();

    for (final registration in registrationsData.docs) {
      _list.add(
        Registration(
          eventId: registration.data()['eventId'] as String,
          registrantId: registration.data()['registrantId'] as String,
        ),
      );
    }

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
}
