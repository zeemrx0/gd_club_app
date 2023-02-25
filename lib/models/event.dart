import 'package:gd_club_app/models/organization.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/registration.dart';
import 'package:gd_club_app/models/role.dart';

class Event {
  String? id;
  String title;
  String location;
  DateTime dateTime;
  String? description;
  List<String> imageUrls;
  Organizer? organizer;
  List<Registration> registrations;

  List<Role> allowedRoles;

  int get numberOfRegistrations {
    return registrations.length;
  }

  bool isRegistered;
  bool isCheckedIn;

  Event({
    this.id,
    required this.title,
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
