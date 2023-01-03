import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Event with ChangeNotifier {
  String? id;
  String title;
  String location;
  DateTime dateTime;
  String? description;
  String organizerId;

  bool isRegistered;

  Event({
    this.id,
    required this.title,
    required this.location,
    required this.dateTime,
    this.description,
    required this.organizerId,
    this.isRegistered = false,
  });

  void toggleRegistered() {
    User user = FirebaseAuth.instance.currentUser!;

    FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .collection('registrations')
        .doc(id)
        .set({
      'dateTime': isRegistered ? null : Timestamp.now(),
    });

    isRegistered = !isRegistered;

    notifyListeners();
  }
}
