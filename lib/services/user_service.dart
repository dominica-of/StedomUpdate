import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:stedom/models/account_model.dart';
import 'package:stedom/utils/constants.dart';

// main api url
String url = ApiEndpoints.baseEndpoint;

class UserService {
  static Future<String> registration(
    UserModel userRegistration,
  ) async {
    try {
      final client = http.Client();
      final response = await client.post(
        Uri.parse('$url/api/v1/account/register'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: userModelToJson(userRegistration),
      );

      if (response.statusCode == 201) {
        return "Account created successfully, please log into your account";
      } else {
        throw json.decode(response.body)["message"];
      }
    } on SocketException {
      // if the device has no internet connection then notify the user
      throw 'No Internet connection';
    } catch (e) {
      // any other error
      rethrow;
    }
  }

  static Future<dynamic> login(
    LoginModel userLogin,
  ) async {
    try {
      final client = http.Client();
      final response = await client.post(
        Uri.parse('$url/api/v1/account/login'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: loginModelToJson(userLogin),
      );
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw json.decode(response.body);
      }
    }  catch (e) {
      // any other error
      rethrow;
    }
  }

  static Future<dynamic> refreshToken(
    String expiredAccessToken,
    String refreshToken,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$url/api/v1/account/refresh'),
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: jsonEncode(<String, String>{
          "refresh": refreshToken
        }),
      );

      // var apiResponse = json.decode(response.body);

      if (response.statusCode == 200) {
        // final token = authTokenFromJson(response.body);
        // LocalStorageService.saveToDisk(
        //     SavedPreferencesKey.accessTokenKey, token.access);
        // LocalStorageService.saveToDisk(
        //     SavedPreferencesKey.refreshTokenKey, token.refresh);
        // return response;
      } else {
        throw Exception('Failed to refresh token ${jsonDecode(response.body)}');
      }
    } on SocketException {
      // if the device has no internet connection then notify the user
      throw 'No Internet connection';
    } catch (e) {
      // any other error
      rethrow;
    }
  }
}
