import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
// ignore: library_prefixes
import 'package:gd_club_app/models/user.dart' as AppUser;

class Auth with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  // String? _token;
  // DateTime? _expiryTime;
  // Timer? _authTimer;

  late AppUser.User currentUser;

  Future<void> fetchAccountData() async {
    final fetchedUser = await db
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    currentUser = AppUser.User(
      id: fetchedUser.id,
      email: fetchedUser.data()!['email'] as String,
      name: fetchedUser.data()!['name'] as String,
      avatarUrl: fetchedUser.data()!['avatarUrl'] as String,
      systemRole: fetchedUser.data()!['systemRole'] as String,
    );
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    fetchAccountData();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    final UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    fetchAccountData();
  }
}
