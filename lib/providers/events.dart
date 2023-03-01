import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/providers/organizers.dart';
import 'package:gd_club_app/providers/registrations.dart';
import 'package:uuid/uuid.dart';

class Events with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Event> _list = [];
  Registrations? _registrationsProvider;
  Organizers? _organizersProvider;

  Events(this._registrationsProvider, this._organizersProvider);

  List<Event> get allEvents {
    return [..._list];
  }

  List<Event> get registeredEvents {
    final User user = FirebaseAuth.instance.currentUser!;

    final registrations =
        _registrationsProvider!.getAllRegistrationsOfAUser(user.uid);

    return allEvents.where((event) {
      final bool isEventRegisterd = registrations.indexWhere(
            (registration) => registration.eventId == event.id,
          ) >=
          0;

      return isEventRegisterd;
    }).toList();
  }

  List<Event> findEventsByOrganizerId(String organizerId) {
    return _list.where((event) => event.organizer!.id == organizerId).toList();
  }

  // ignore: use_setters_to_change_properties
  void update(
    Registrations registrationsProvider,
    Organizers organizersProvider,
  ) {
    _registrationsProvider = registrationsProvider;
    _organizersProvider = organizersProvider;

    notifyListeners();
  }

  Event findEventById(String id) {
    return _list[_list.indexWhere((event) => event.id == id)];
  }

  Future<void> fetchEvents() async {
    if (_registrationsProvider == null || _organizersProvider == null) {
      return;
    }

    final User user = FirebaseAuth.instance.currentUser!;

    final eventsData =
        await db.collection('events').orderBy('_createdAt').get();

    final List<Event> eventList = [];

    for (final eventData in eventsData.docs) {
      final event = eventData.data();

      final registrations = _registrationsProvider!.getAllRegistrations();
      final Organizer organizer = _organizersProvider!
          .findOrganizerById(event['organizerId'] as String)!;

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
          organizer: organizer,
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
      'organizerId': event.organizer!.id,
      '_createdAt': Timestamp.now(),
    });

    event.id = eventData.id;
    _list.insert(0, event);

    notifyListeners();
  }

  Future<void> updateEvent(
      String updatingEvenId, Event newEvent, File? image) async {
    for (Event event in _list) {
      if (event.id == updatingEvenId) {
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

        event = Event(
          title: newEvent.title,
          location: newEvent.location,
          dateTime: newEvent.dateTime,
          imageUrls: newEvent.imageUrls,
          description: newEvent.description,
          organizer: newEvent.organizer,
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
      'teamId': newEvent.organizer!.id,
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

  Future<void> toggleEventRegisteredStatus(String eventId) async {
    final int eventIndex = _list.indexWhere((event) => event.id == eventId);

    final User user = FirebaseAuth.instance.currentUser!;

    if (!_list[eventIndex].isRegistered) {
      // If you have not registered the event
      // then add a registration

      await _registrationsProvider!.addRegistration(
          eventId: _list[eventIndex].id!, registrantId: user.uid);

      _list[eventIndex].isRegistered = true;
    } else {
      // If you have already registered the event
      // then delete the registration

      await _registrationsProvider!.removeRegistration(
          eventId: _list[eventIndex].id!, registrantId: user.uid);

      _list[eventIndex].isRegistered = false;
    }

    notifyListeners();
  }
}
