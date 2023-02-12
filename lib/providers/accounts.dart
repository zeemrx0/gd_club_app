import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/providers/account.dart';

class Accounts {
  final db = FirebaseFirestore.instance;

  Future<Account> getAccount(String uid, String email) async {
    final userData = await db.collection('users').doc(uid).get();

    final user = userData.data() as Map<String, dynamic>;

    return Account(
      id: uid,
      email: email,
      name: user['name'] as String,
      avatarUrl: user['avatarUrl'] as String,
    );
  }
}
