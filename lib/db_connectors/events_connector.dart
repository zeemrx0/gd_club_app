// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:gd_club_app/db_connectors/organizers_connector.dart';
import 'package:gd_club_app/db_connectors/registrations_connector.dart';
import 'package:gd_club_app/db_connectors/rest_client.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/registration.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class EventsConnector {
  static final db = FirebaseFirestore.instance;

  static Future<List<Event>> getEvents() async {
    final fetchedEvents = await RestClient().get('/events') as List<dynamic>;

    final List<Event> events = [];

    for (final event in fetchedEvents) {
      final organizerData = event['organizer'] as dynamic;
      Organizer organizer;

      if (organizerData['roles'] == null) {
        organizer = User(
          id: organizerData['_id'] as String,
          email: organizerData['email'] as String,
          name: organizerData['name'] as String,
          systemRole: organizerData['role'] as String,
        );
      } else {
        organizer = Team(
          organizerData['_id'] as String,
          organizerData['name'] as String,
          organizerData['avatarUrl'] as String,
        );
      }

      final registrationsData = event['registrations'] as List<dynamic>;
      final List<Registration> registrations = registrationsData
          .map(
            (registration) => Registration(
              eventId: registration['event'] as String,
              registrantId: registration['registrant'] as String,
            ),
          )
          .toList();

      events.insert(
        0,
        Event(
          id: event['_id'] as String,
          title: event['name'] as String,
          location: event['location'] as String,
          dateTime: DateTime.parse(event['dateTime'] as String),
          description: event['description'] as String,
          imageUrls: (event['imageUrls'] as List<dynamic>)
              .map((e) => e.toString())
              .toList(),
          organizer: organizer,
          registrations: registrations,
          isRegistered: false,
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

    final eventData = await RestClient().post(
      '/events',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'name': event.title,
          'location': event.location,
          'dateTime': event.dateTime.toIso8601String(),
          'imageUrls': imageUrls,
          'description': event.description,
          'organizerId': event.organizer!.id,
        },
      ),
    );

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
    await RestClient().delete('/events/$eventId');
  }
}
