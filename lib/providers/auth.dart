// ignore_for_file: avoid_dynamic_calls

import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:gd_club_app/db_connectors/auth_connector.dart';
// ignore: library_prefixes
import 'package:gd_club_app/models/user.dart' as AppUser;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  // String? _token;
  // DateTime? _expiryTime;
  // Timer? _authTimer;

  AppUser.User? currentUser;

  Future<void> saveUserDataToLocal() async {
    final prefs = await SharedPreferences.getInstance();
    final userJsonData = json.encode({
      'id': currentUser?.id,
      'email': currentUser?.email,
      'name': currentUser?.name,
      'systemRole': currentUser?.systemRole,
    });

    prefs.setString('user', userJsonData);
  }

  Future<bool> isAuth() async {
    final prefs = await SharedPreferences.getInstance();

    if (!prefs.containsKey('user')) {
      return false;
    }

    final userData =
        json.decode(prefs.getString('user')!) as Map<String, dynamic>;

    currentUser = AppUser.User(
      id: userData['id'] as String,
      email: userData['email'] as String,
      name: userData['name'] as String,
      systemRole: userData['systemRole'] as String,
    );

    notifyListeners();

    return true;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    final authData =
        await AuthConnector.login(email: email, password: password);

    if (authData != null) {
      final userData = authData['user'];

      currentUser = AppUser.User(
        id: userData['id'] as String,
        email: userData['email'] as String,
        name: userData['name'] as String,
        systemRole: userData['role'] as String,
      );

      await saveUserDataToLocal();
    }

    notifyListeners();
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    final authData = await AuthConnector.signup(
        email: email, password: password, name: 'User');

    if (authData != null) {
      final userData = authData['user'];

      currentUser = AppUser.User(
        id: userData['id'] as String,
        email: userData['email'] as String,
        name: userData['name'] as String,
        systemRole: userData['role'] as String,
      );

      await saveUserDataToLocal();
    }

    notifyListeners();
  }

  Future<void> logOut() async {
    currentUser = null;

    final prefs = await SharedPreferences.getInstance();

    prefs.clear();

    notifyListeners();
  }
}
