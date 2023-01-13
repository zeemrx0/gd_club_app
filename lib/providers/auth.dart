import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Auth with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  String? _token;
  DateTime? _expiryTime;
  String? _uid;
  Timer? _authTimer;

  String? _name;
  String? _imageUrl;

  String? get name {
    return _name;
  }

  String? get imageUrl {
    return _imageUrl;
  }

  void setUID(String uid) {
    _uid = uid;
  }

  void getUserData(String uid) async {
    final userData = await db.collection('users').doc(uid).get();
    final user = userData.data() as Map<String, dynamic>;

    _name = user['name'];
    _imageUrl = user['imageUrl'];
  }

  void signInWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);

    _uid = userCredential.user!.uid;

    getUserData(_uid!);
  }

  void signUpWithEmailAndPassword(String email, String password) async {
    UserCredential userCredential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    _uid = userCredential.user!.uid;

    getUserData(_uid!);
  }
}
