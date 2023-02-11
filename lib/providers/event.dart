import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/role.dart';

class Event with ChangeNotifier {
  String? id;
  String title;
  String location;
  DateTime dateTime;
  String? description;
  List<String> imageUrls;
  String organizerId;
  String organizerName;
  int noRegisters;

  List<Role> allowedRoles;

  bool isRegistered;
  bool isCheckedIn;

  Event({
    this.id,
    required this.title,
    required this.location,
    required this.dateTime,
    this.description,
    this.imageUrls = const [],
    required this.organizerId,
    required this.organizerName,
    required this.noRegisters,
    this.allowedRoles = const [],
    this.isRegistered = false,
    this.isCheckedIn = false,
  });

  void toggleRegistered() {
    final User user = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('registrations')
        .doc(id)
        .set({
      'dateTime': isRegistered ? null : Timestamp.now(),
    });

    if (isRegistered) {
      noRegisters = noRegisters - 1;
    } else {
      noRegisters = noRegisters + 1;
    }

    FirebaseFirestore.instance.collection('events').doc(id).update({
      'noRegisters': noRegisters,
    });

    isRegistered = !isRegistered;

    notifyListeners();
  }
}
