import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/User.dart';

class Users {
  static final db = FirebaseFirestore.instance;

  static Future<User> getUser(String uid) async {
    final userData = await db.collection('users').doc(uid).get();
    final user = userData.data() as Map<String, dynamic>;

    return User(
      id: uid,
      name: user['name'],
      imageUrl: user['imageUrl'],
    );
  }
}
