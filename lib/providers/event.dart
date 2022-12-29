import 'package:flutter/material.dart';

class Event with ChangeNotifier {
  final String? id;
  final String title;
  final String address;
  final DateTime dateTime;
  final String? description;
  final String organizerId;

  bool isRegistered;

  Event({
    this.id,
    required this.title,
    required this.address,
    required this.dateTime,
    this.description,
    required this.organizerId,
    this.isRegistered = false,
  });
}
