import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/providers/organization.dart';

class Organizations {
  final db = FirebaseFirestore.instance;

  Future<Organization> getOrganization(String id) async {
    final organizationData = await db.collection('organizations').doc(id).get();

    final organization = organizationData.data() as Map<String, dynamic>;

    return Organization(
      name: organization['name'] as String,
      avatarUrl: organization['avatarUrl'] as String,
    );
  }
}
