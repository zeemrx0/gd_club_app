import 'package:gd_club_app/db_connectors/rest_client.dart';

class AuthConnector {
  AuthConnector._();

  static Future<dynamic> login(
      {required String email, required String password}) async {
    try {
      final response = await RestClient()
          .post('/auth/login', body: {'email': email, 'password': password});

      return response;
    } catch (e) {
      return null;
    }
  }

  static Future<dynamic> signup(
      {required String email,
      required String password,
      required String name}) async {
    try {
      final response = await RestClient().post('/auth/register',
          body: {'email': email, 'password': password, 'name': name});

      return response;
    } catch (e) {
      return null;
    }
  }
}
