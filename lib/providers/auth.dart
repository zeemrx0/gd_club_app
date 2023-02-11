import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/User.dart' as app_user;
import 'package:gd_club_app/providers/users.dart';

class Auth with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  // String? _token;
  // DateTime? _expiryTime;
  // Timer? _authTimer;

  app_user.User? user;

  Future<void> fetchUserData() async {
    user = await Users.getUser(FirebaseAuth.instance.currentUser!.uid);
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    fetchUserData();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    fetchUserData();
  }
}
