import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/event.dart';

class Events with ChangeNotifier {
  final List<Event> _list = [
    Event(
      id: '603e86ed-3912-4678-8ce0-c73663e81164',
      title: 'Training arduino buổi 1',
      address: '99B Võ Oanh',
      dateTime: DateTime.parse('2022-12-24 11:00:00').toLocal(),
      description: 'Kiến thức cơ bản về Arduino',
      organizerId: '1',
      isRegistered: true,
    ),
    Event(
      id: '603e86ed-3912-4678-8ce0-c73663e81164',
      title: 'Training Flutter cơ bản',
      address: '99B Võ Oanh',
      dateTime: DateTime.parse('2023-02-12 11:00:00').toLocal(),
      description: 'Làm quiz app với Flutter',
      organizerId: '1',
      isRegistered: false,
    ),
  ];

  List<Event> get allEvents {
    return [..._list];
  }
}
