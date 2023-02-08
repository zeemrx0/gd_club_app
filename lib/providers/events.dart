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
    String userId = FirebaseAuth.instance.currentUser!.uid;
    return [..._list.where((e) => e.organizerId == userId)];
  }

  List<Event> get registeredEvents {
    return [..._list.where((e) => e.isRegistered)];
  }

  void fetchEvents() async {
    final eventsData =
        await db.collection('events').orderBy('_createdAt').get();

    User user = FirebaseAuth.instance.currentUser!;
    final registrationsData = await db
        .collection('users')
        .doc(user.uid)
        .collection('registrations')
        .get();

    var eventList = [];

    _list = [];

    for (var event in eventsData.docs) {
      bool isRegistered = registrationsData.docs.indexWhere(
              (reg) => reg.id == event.id && reg.data()['dateTime'] != null) >
          -1;
      eventList.insert(
        0,
        Event(
          id: event.id,
          title: event.data()['title'],
          location: event.data()['location'],
          dateTime: DateTime.fromMicrosecondsSinceEpoch(
              (event.data()['dateTime'] as Timestamp).microsecondsSinceEpoch),
          description: event.data()['description'],
          imageUrls: event.data()['imageUrls'],
          organizerId: event.data()['organizerId'],
          organizerName:
              (await Users.getUser(event.data()['organizerId'])).name,
          noRegisters: event.data()['noRegisters'],
          isRegistered: isRegistered,
        ),
      );
    }

    _list = [...eventList];

    notifyListeners();
  }

  void addEvent(Event event, File? image) async {
    final imageId = Uuid().v4();

    final imageUrls = [];
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

  void updateEvent(String updatingEvenId, Event newEvent) async {
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

    final eventData = await db.collection('events').doc(updatingEvenId).set({
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

  void deleteEvent(String deletingEventId) async {
    await db.collection('events').doc(deletingEventId).delete();
    _list.removeWhere(
      (event) => event.id == deletingEventId,
    );

    notifyListeners();
  }

  Event findEventById(String id) {
    return _list[_list.indexWhere((event) => event.id == id)];
  }
}
