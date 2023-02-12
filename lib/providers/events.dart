import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/accounts.dart';
import 'package:gd_club_app/providers/event.dart';
import 'package:gd_club_app/providers/organizations.dart';
import 'package:gd_club_app/providers/registrations.dart';
import 'package:uuid/uuid.dart';

class Events with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Event> _list = [];

  List<Event> get allEvents {
    return [..._list];
  }

  List<Event> get registeredEvents {
    final User user = FirebaseAuth.instance.currentUser!;

    final registrations = Registrations().getAllRegistrationsOfAUser(user.uid);

    return allEvents.where((event) {
      final bool isEventRegisterd = registrations.indexWhere(
            (registration) => registration.eventId == event.id,
          ) >=
          0;

      return isEventRegisterd;
    }).toList();
  }

  Future<void> fetchEvents() async {
    final User user = FirebaseAuth.instance.currentUser!;

    final eventsData = await db.collection('events').get();

    final List<Event> eventList = [];

    for (final eventData in eventsData.docs) {
      final registrations = Registrations().getAllRegistrations();

      final event = eventData.data();

      eventList.insert(
        0,
        Event(
          id: eventData.id,
          title: event['title'] as String,
          location: event['location'] as String,
          dateTime: DateTime.fromMicrosecondsSinceEpoch(
              (event['dateTime'] as Timestamp).microsecondsSinceEpoch),
          description: event['description'] as String,
          imageUrls: (event['imageUrls'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
          organizationId: event['organizationId'] as String,
          organizationName: (await Organizations()
                  .getOrganization(event['organizationId'] as String))
              .name,
          registrations: registrations,
          isRegistered: registrations.indexWhere(
                (registration) => registration.registrantId == user.uid,
              ) >=
              0,
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
      'organizationId': event.organizationId,
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
          organizationId: newEvent.organizationId,
          organizationName: newEvent.organizationName,
          registrations: [],
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
      'organizationId': newEvent.organizationId,
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
