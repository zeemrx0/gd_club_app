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
}
