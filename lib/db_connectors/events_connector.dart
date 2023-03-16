// ignore_for_file: avoid_classes_with_only_static_members

import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'package:gd_club_app/db_connectors/rest_client.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/registration.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:uuid/uuid.dart';

class EventsConnector {
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
          name: event['name'] as String,
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

    event.imageUrls = [...imageUrls];

    final eventData = await RestClient().post(
      '/events',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'name': event.name,
          'location': event.location,
          'dateTime': event.dateTime.toIso8601String(),
          'imageUrls': imageUrls,
          'description': event.description,
          'organizerId': event.organizer!.id,
        },
      ),
    );

    event.id = eventData['_id'] as String;

    return event;
  }

  static Future<Event> updateEvent({
    required String eventId,
    required Event newEvent,
    File? image,
  }) async {
    final eventData = await RestClient().put(
      '/events/$eventId',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'name': newEvent.name,
          'location': newEvent.location,
          'dateTime': '${newEvent.dateTime.toIso8601String()}Z',
          'imageUrls': newEvent.imageUrls,
          'description': newEvent.description,
        },
      ),
    );

    return newEvent;
  }

  static Future<void> deleteEvent({required String eventId}) async {
    await RestClient().delete('/events/$eventId');
  }

  static Future<void> addRegistration({
    required String eventId,
    required registrantId,
  }) async {
    final registrationData = await RestClient().post(
      '/registrations',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'event': eventId,
          'registrant': registrantId,
        },
      ),
    );
  }

  static Future<void> deleteRegistration({
    required String eventId,
    required registrantId,
  }) async {
    final registrationData = await RestClient().delete(
      '/registrations',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'event': eventId,
          'registrant': registrantId,
        },
      ),
    );
  }
}
