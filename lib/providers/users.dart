import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/user.dart';

class Users with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<User> _list = [];

  Future<void> fetchUsers() async {
    List<User> userList = [];

    final users = await db.collection('events').orderBy('_createdAt').get();

    for (final user in users.docs) {
      final userData = user.data();

      userList.add(
        User(
          id: user['id'] as String,
          email: user['email'] as String,
          name: user['name'] as String,
          systemRole: user['systemRole'] as String,
        ),
      );
    }

    notifyListeners();
  }

  User? findUserById(String userId) {
    final index = _list.indexWhere((user) => user.id == userId);

    return index >= 0 ? _list[index] : null;
  }
}
