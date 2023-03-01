import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/user.dart';

class Users with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<User> _list = [];

  Future<void> fetchUsers() async {
    final List<User> userList = [];

    final users = await db.collection('users').orderBy('_createdAt').get();

    for (final user in users.docs) {
      final userData = user.data();

      userList.add(
        User(
          id: userData['id'] as String,
          email: userData['email'] as String,
          name: userData['name'] as String,
          systemRole: userData['systemRole'] as String,
        ),
      );
    }

    _list = [...userList];

    notifyListeners();
  }

  User? findUserById(String userId) {
    final index = _list.indexWhere((user) => user.id == userId);

    return index >= 0 ? _list[index] : null;
  }
}
