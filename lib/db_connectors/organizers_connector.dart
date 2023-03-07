// ignore_for_file: avoid_classes_with_only_static_members

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/models/organizer.dart';
import 'package:gd_club_app/models/team.dart';
import 'package:gd_club_app/models/user.dart';

class OrganizersConnectors {
  static final db = FirebaseFirestore.instance;

  static Future<Organizer> getOrganizerById(String organizerId) async {
    final user = await db.collection('users').doc(organizerId).get();
    if (user.exists) {
      final userData = user.data()!;
      final Organizer organizer = User(
        id: user.id,
        email: userData['email'] as String,
        name: userData['name'] as String,
        systemRole: userData['systemRole'] as String,
      );

      return organizer;
    }

    final team = await db.collection('teams').doc(organizerId).get();
    final teamData = team.data()!;
    final Organizer organizer = Team(
      team.id,
      teamData['name'] as String,
      teamData['avatarUrl'] as String,
    );

    return organizer;
  }
}
