import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/Users.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:uuid/uuid.dart';

class Events with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Event> _list = [];

  List<Event> get allEvents {
    return [..._list];
  }

  List<Event> get ownedEvents {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    return [..._list.where((e) => e.organizerId == userId)];
  }

  List<Event> get registeredEvents {
    return [..._list.where((e) => e.isRegistered)];
  }

  Future<void> fetchEvents() async {
    final eventsData =
        await db.collection('events').orderBy('_createdAt').get();

    final User user = FirebaseAuth.instance.currentUser!;
    final registrationsData = await db
        .collection('users')
        .doc(user.uid)
        .collection('registrations')
        .get();

    final List<Event> eventList = [];

    _list = [];

    for (final event in eventsData.docs) {
      final bool isRegistered = registrationsData.docs.indexWhere(
              (reg) => reg.id == event.id && reg.data()['dateTime'] != null) >
          -1;
      eventList.insert(
        0,
        Event(
          id: event.id,
          title: event.data()['title'] as String,
          location: event.data()['location'] as String,
          dateTime: DateTime.fromMicrosecondsSinceEpoch(
              (event.data()['dateTime'] as Timestamp).microsecondsSinceEpoch),
          description: event.data()['description'] as String,
          imageUrls: (event.data()['imageUrls'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
          organizerId: event.data()['organizerId'] as String,
          organizerName:
              (await Users.getUser(event.data()['organizerId'] as String)).name,
          noRegisters: event.data()['noRegisters'] as int,
          isRegistered: isRegistered,
        ),
      );
    }

    _list = [...eventList];

    notifyListeners();
  }

  Future<void> addEvent(Event event, File? image) async {
    final String imageId = const Uuid().v4();

    final List<String> imageUrls = [];
    if (image != null) {
      final ref = FirebaseStorage.instance
          .ref()
          .child('event_images')
          .child('$imageId.jpg');

      await ref.putFile(image);

      final url = await ref.getDownloadURL();

      imageUrls.add(url);
    }

    final eventData = await db.collection('events').add({
      'title': event.title,
      'location': event.location,
      'dateTime': event.dateTime,
      'imageUrls': imageUrls,
      'description': event.description,
      'organizerId': event.organizerId,
      'organizerName': event.organizerName,
      '_createdAt': Timestamp.now(),
      'noRegisters': 0
    });

    event.id = eventData.id;
    _list.insert(0, event);

    notifyListeners();
  }

  Future<void> updateEvent(String updatingEvenId, Event newEvent) async {
    for (Event event in _list) {
      if (event.id == updatingEvenId) {
        event = Event(
          title: newEvent.title,
          location: newEvent.location,
          dateTime: newEvent.dateTime,
          imageUrls: newEvent.imageUrls,
          description: newEvent.description,
          organizerId: newEvent.organizerId,
          organizerName: newEvent.organizerName,
          noRegisters: newEvent.noRegisters,
        );

        event.id = updatingEvenId;

        break;
      }
    }

    await db.collection('events').doc(updatingEvenId).set({
      'title': newEvent.title,
      'location': newEvent.location,
      'dateTime': newEvent.dateTime,
      'imageUrls': newEvent.imageUrls,
      'description': newEvent.description,
      'organizerId': newEvent.organizerId,
      'noRegisters': newEvent.noRegisters,
      '_createdAt': Timestamp.now(),
    });

    notifyListeners();
  }

  Future<void> deleteEvent(String deletingEventId) async {
    await db.collection('events').doc(deletingEventId).delete();
    _list.removeWhere(
      (event) => event.id == deletingEventId,
    );

    notifyListeners();
  }

  Event findEventById(String id) {
    return _list[_list.indexWhere((event) => event.id == id)];
  }

  void toggleEventRegisteredStatus(String id) {
    final event = _list.firstWhere((event) => event.id == id);

    event.toggleRegistered();

    notifyListeners();
  }
}
