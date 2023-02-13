import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gd_club_app/models/account.dart';

class Accounts {
  final db = FirebaseFirestore.instance;

  Future<Account> getAccount(String uid, String email) async {
    final accountData = await db.collection('users').doc(uid).get();

    final account = accountData.data() as Map<String, dynamic>;

    return Account(
      id: uid,
      email: email,
      name: account['name'] as String,
      avatarUrl: account['avatarUrl'] as String,
      systemRole: account['systemRole'] as String,
    );
  }
}
