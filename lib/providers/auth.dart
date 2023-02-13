import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/providers/account.dart';

import 'package:gd_club_app/providers/accounts.dart';

class Auth with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  // String? _token;
  // DateTime? _expiryTime;
  // Timer? _authTimer;

  Account? account;

  Future<void> fetchAccountData() async {
    account = await Accounts().getAccount(
      FirebaseAuth.instance.currentUser!.uid,
      FirebaseAuth.instance.currentUser!.email!,
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
