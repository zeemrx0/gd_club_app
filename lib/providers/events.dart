import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/db_connectors/events_connector.dart';
import 'package:gd_club_app/models/event.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:gd_club_app/providers/registrations.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class Events with ChangeNotifier {
  List<Event> _list = [];

  List<Event> get allEvents {
    return [..._list];
  }

  List<Event> get registeredEvents {
    return allEvents.where((event) => event.isRegistered).toList();
  }

  List<Event> findEventsByOrganizerId(String organizerId) {
    return _list.where((event) => event.organizer!.id == organizerId).toList();
  }

  Event? findEventById(String id) {
    final int index = _list.indexWhere((event) => event.id == id);
    return index < 0 ? null : _list[index];
  }

  bool hasRegisteredAnEvent(String eventId) {
    return findEventById(eventId)!.isRegistered;
  }

  Future<void> fetchEvents() async {
    final List<Event> events = await EventsConnector.getEvents();

    _list = [...events];

    notifyListeners();
  }

  Future<void> addEvent(Event event, File? image) async {
    event = await EventsConnector.addEvent(
      event: event,
      image: image,
    );

    _list.insert(0, event);

    notifyListeners();
  }

  Future<void> updateEvent(
    String eventId,
    Event newEvent,
    File? image,
  ) async {
    for (Event event in _list) {
      if (event.id == eventId) {
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

        event.id = eventId;

        break;
      }
    }

    EventsConnector.updateEvent(
      eventId: eventId,
      newEvent: newEvent,
      image: image,
    );

    notifyListeners();
  }

  Future<void> deleteEvent(String eventId) async {
    _list.removeWhere(
      (event) => event.id == eventId,
    );

    EventsConnector.deleteEvent(
      eventId: eventId,
    );

    notifyListeners();
  }

  Future<void> toggleRegisteredAnEvent(
      String eventId, BuildContext context) async {
    final String userId =
        Provider.of<Auth>(context, listen: false).currentUser.id;

    final bool hasRegistered = hasRegisteredAnEvent(eventId);

    if (hasRegistered) {
      await Provider.of<Registrations>(context, listen: false)
          .removeRegistration(
        eventId: eventId,
        registrantId: userId,
      );

      findEventById(eventId)!.isRegistered = false;
    } else {
      await Provider.of<Registrations>(context, listen: false).addRegistration(
        eventId: eventId,
        registrantId: userId,
      );

      findEventById(eventId)!.isRegistered = true;
    }

    notifyListeners();
  }
}
