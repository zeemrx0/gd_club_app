import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/registration.dart';
import 'package:gd_club_app/models/role.dart';

class Event {
  String? id;
  String name;
  String location;
  DateTime dateTime;
  String? description;
  List<String> imageUrls;
  Organizer? organizer;
  List<Registration> registrations;

  List<Role> allowedRoles;

  bool isRegistered;
  bool isCheckedIn;

  Event({
    this.id,
    required this.name,
    required this.location,
    required this.dateTime,
    this.description,
    this.imageUrls = const [],
    required this.organizer,
    required this.registrations,
    this.allowedRoles = const [],
    this.isRegistered = false,
    this.isCheckedIn = false,
  });
}
