import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:gd_club_app/models/organization.dart';

class Organizations with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<Organization> _list = const [];

  List<Organization> get list {
    return [..._list];
  }

  Organization findOrganizationById(String id) {
    return _list.firstWhere((organization) => organization.id == id);
  }

  Future<void> fetchOrganizations() async {
    final organizationsData = await db.collection('organizations').get();

    final List<Organization> organizationList = [];

    for (final organization in organizationsData.docs) {
      final organizationData = organization.data();

      organizationList.add(
        Organization(
            id: organization.id,
            name: organizationData['name'] as String,
            avatarUrl: organizationData['avatarUrl'] as String),
      );
    }

    _list = [...organizationList];

    notifyListeners();
  }
}
