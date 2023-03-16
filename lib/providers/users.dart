import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:gd_club_app/db_connectors/rest_client.dart';
import 'package:gd_club_app/db_connectors/users_connector.dart';
import 'package:gd_club_app/models/user.dart';
import 'package:gd_club_app/providers/auth.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Users with ChangeNotifier {
  final db = FirebaseFirestore.instance;

  List<User> _list = [];

  Future<void> fetchUsers() async {
    final List<User> userList = [];

    final fetchedData = await RestClient().get('/users') as dynamic;
    final fetchedUser = fetchedData['results'] as List<dynamic>;

    for (final user in fetchedUser) {
      userList.add(
        User(
          id: user['id'] as String,
          email: user['email'] as String,
          avatarUrl: user['avatarUrl'] as String?,
          name: user['name'] as String,
          systemRole: user['role'] as String,
        ),
      );
    }

    _list = [...userList];

    notifyListeners();
  }

  Future<void> updateUser(
      String userId, User newUser, File? image, BuildContext context) async {
    for (User user in _list) {
      if (user.id == userId) {
        // final String imageId = const Uuid().v4();

        // final List<String> imageUrls = [];
        // if (image != null) {
        //   final ref = FirebaseStorage.instance
        //       .ref()
        //       .child('user_images')
        //       .child('$imageId.jpg');

        //   await ref.putFile(image);

        //   final url = await ref.getDownloadURL();

        //   imageUrls.add(url);
        // }

        user = User(
          id: userId,
          name: newUser.name,
          email: newUser.email,
          systemRole: newUser.systemRole,
        );

        user.id = userId;

        break;
      }
    }

    UsersConnector.updateUser(
      userId: userId,
      newUser: newUser,
      image: image,
    );

    Provider.of<Auth>(context, listen: false).currentUser = newUser;

    final prefs = await SharedPreferences.getInstance();
    final userJsonData = jsonEncode({
      'id': newUser.id,
      'email': newUser.email,
      'name': newUser.name,
      'systemRole': newUser.systemRole,
    });

    prefs.setString('user', userJsonData);

    notifyListeners();
  }

  User? findUserById(String userId) {
    final index = _list.indexWhere((user) => user.id == userId);

    return index >= 0 ? _list[index] : null;
  }
}
