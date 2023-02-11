import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/providers/User.dart';
import 'package:gd_club_app/providers/account.dart';

// ignore: avoid_classes_with_only_static_members
class Accounts {
  static final db = FirebaseFirestore.instance;

  static Future<Account> getAccount(String uid, String email) async {
    final userData = await db.collection('users').doc(uid).get();

    final user = userData.data() as Map<String, dynamic>;

    return Account(
      id: uid,
      email: email,
      name: user['name'] as String,
      imageUrl: user['imageUrl'] as String,
    );
  }
}
