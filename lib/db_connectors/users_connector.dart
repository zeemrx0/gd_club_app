import 'dart:convert';
import 'dart:io';

import 'package:gd_club_app/db_connectors/constants/endpoints.dart';
import 'package:gd_club_app/db_connectors/rest_client.dart';
import 'package:gd_club_app/models/user.dart';

class UsersConnector {
  UsersConnector._();

  // static Future<User> getUser() async {
  //   RestClient().get(Endpoints.baseUrl + '/');

  //   return user;
  // }

  static Future<User> updateUser({
    required String userId,
    required User newUser,
    File? image,
  }) async {
    final userData = await RestClient().put(
      '/users/$userId',
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(
        {
          'name': newUser.name,
          'email': newUser.email,
          'systemRole': newUser.systemRole,
        },
      ),
    );

    return newUser;
  }
}
