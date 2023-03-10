// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gd_club_app/db_connectors/organizers_connector.dart';
import 'package:gd_club_app/db_connectors/registrations_connector.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/registration.dart';
import 'package:uuid/uuid.dart';

class EventsConnector {
  static final db = FirebaseFirestore.instance;

  static Future<List<Event>> getEvents() async {
    final User user = FirebaseAuth.instance.currentUser!;

    final fetchedEvents =
        await db.collection('events').orderBy('_createdAt').get();

    final List<Event> events = [];

    for (final event in fetchedEvents.docs) {
      final eventData = event.data();

      final String organizerId = eventData['organizerId'] as String;
      final Organizer organizer =
          await OrganizersConnectors.getOrganizerById(organizerId);

      final List<Registration> registrations =
          await RegistrationsConnector.getRegistrationsOfAnEvent(
        eventId: event.id,
      );

      final bool hasUserRegistered = registrations.indexWhere(
              (registration) => registration.registrantId == user.uid) >=
          0;

      events.insert(
        0,
        Event(
          id: event.id,
          title: eventData['title'] as String,
          location: eventData['location'] as String,
          dateTime: DateTime.fromMicrosecondsSinceEpoch(
              (eventData['dateTime'] as Timestamp).microsecondsSinceEpoch),
          description: eventData['description'] as String,
          imageUrls: (eventData['imageUrls'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
          organizer: organizer,
          registrations: registrations,
          isRegistered: hasUserRegistered,
        ),
      );
    }

    return events;
  }

  static Future<Event> addEvent({
    required Event event,
    File? image,
  }) async {
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

    return event;
  }

  static Future<Event> updateEvent({
    required String eventId,
    required Event newEvent,
    File? image,
  }) async {
    await db.collection('events').doc(eventId).set({
      'title': newEvent.title,
      'location': newEvent.location,
      'dateTime': newEvent.dateTime,
      'imageUrls': newEvent.imageUrls,
      'description': newEvent.description,
      'teamId': newEvent.organizer!.id,
      '_createdAt': Timestamp.now(),
    });

    return newEvent;
  }

  static Future<void> deleteEvent({required String eventId}) async {
    await db.collection('events').doc(eventId).delete();
  }
}
