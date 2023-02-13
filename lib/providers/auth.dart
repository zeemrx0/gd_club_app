import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gd_club_app/models/account.dart';
// ignore: library_prefixes
import 'package:gd_club_app/models/user.dart' as AuthUser;
import 'package:gd_club_app/providers/accounts.dart';
import 'package:gd_club_app/providers/participations.dart';

class Auth with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  // String? _token;
  // DateTime? _expiryTime;
  // Timer? _authTimer;

  Account? account;

  Future<void> fetchAccountData() async {
    final authenticatingAccount = await Accounts().getAccount(
      FirebaseAuth.instance.currentUser!.uid,
      FirebaseAuth.instance.currentUser!.email!,
    );

    if (authenticatingAccount.systemRole == 'User') {
      account = AuthUser.User(
        id: authenticatingAccount.id,
        email: authenticatingAccount.email,
        name: authenticatingAccount.name,
        systemRole: authenticatingAccount.systemRole,
        participations: await Participations()
            .getParticipationsOfAUser(userId: authenticatingAccount.id),
      );
    }
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
