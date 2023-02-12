import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/registration.dart';
import 'package:gd_club_app/providers/role.dart';

class Event with ChangeNotifier {
  String? id;
  String title;
  String location;
  DateTime dateTime;
  String? description;
  List<String> imageUrls;
  String organizationId;
  String organizationName;
  List<Registration> registrations;

  List<Role> allowedRoles;

  int get numberOfRegistrations {
    return registrations.length;
  }

  bool isRegistered;
  bool isCheckedIn;

  Event({
    this.id,
    required this.title,
    required this.location,
    required this.dateTime,
    this.description,
    this.imageUrls = const [],
    required this.organizationId,
    required this.organizationName,
    required this.registrations,
    this.allowedRoles = const [],
    this.isRegistered = false,
    this.isCheckedIn = false,
  });

  Future<void> toggleRegistered() async {
    final User user = FirebaseAuth.instance.currentUser!;

    if (!isRegistered) {
      // If you have not registered the event
      // then add a registration

      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('registrations')
          .add(
        {
          'eventId': id,
          'registrantId': user.uid,
        },
      );

      isRegistered = true;
    } else {
      // If you have already registered the event
      // then delete the registration

      final registrations = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .collection('registrations')
          .where(
            'registrantId',
            isEqualTo: user.uid,
          )
          .where('eventId', isEqualTo: id)
          .get();

      for (final registration in registrations.docs) {
        registration.reference.delete();
      }
    }

    notifyListeners();
  }
}
