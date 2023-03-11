import 'dart:async';
import 'dart:convert';

import 'package:gd_club_app/db_connectors/constants/endpoints.dart';
import 'package:gd_club_app/db_connectors/exceptions/network_exception.dart';
import 'package:http/http.dart' as http;

class RestClient {
  // instantiate json decoder for json serialization
  final JsonDecoder _decoder = const JsonDecoder();

  // Get:-----------------------------------------------------------------------
  Future<dynamic> get(String path) {
    return http
        .get(Uri.parse('${Endpoints.baseUrl}$path'))
        .then(_createResponse);
  }

  // Post:----------------------------------------------------------------------
  Future<dynamic> post(String path,
      {Map<String, String>? headers, body, Encoding? encoding}) {
    return http
        .post(
          Uri.parse('${Endpoints.baseUrl}${path}'),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Put:----------------------------------------------------------------------
  Future<dynamic> put(String path,
      {Map<String, String>? headers, body, Encoding? encoding}) {
    return http
        .put(
          Uri.parse('${Endpoints.baseUrl}${path}'),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Delete:----------------------------------------------------------------------
  Future<dynamic> delete(String path,
      {Map<String, String>? headers, body, Encoding? encoding}) {
    return http
        .delete(
          Uri.parse('${Endpoints.baseUrl}${path}'),
          body: body,
          headers: headers,
          encoding: encoding,
        )
        .then(_createResponse);
  }

  // Response:------------------------------------------------------------------
  dynamic _createResponse(http.Response response) {
    final String res = response.body;
    final int statusCode = response.statusCode;

    if (statusCode < 200 || statusCode > 400) {
      throw NetworkException(
          message: 'Error fetching data from server', statusCode: statusCode);
    }

    return _decoder.convert(res);
  }
}
