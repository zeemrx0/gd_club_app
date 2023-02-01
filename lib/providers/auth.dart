import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/User.dart' as appUser;
import 'package:gd_club_app/providers/users.dart';

class Auth with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  String? _token;
  DateTime? _expiryTime;
  Timer? _authTimer;

  appUser.User? _user;

  appUser.User? get user {
    return _user;
  }

  void setUser(appUser.User user) {
    _user = user;
  }

  void fetchUserData() async {
    _user = await Users.getUser(FirebaseAuth.instance.currentUser!.uid);
  }

  void signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    fetchUserData();
  }

  void signUpWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    fetchUserData();
  }
}
