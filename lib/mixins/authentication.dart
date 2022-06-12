import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet_integrated/models/user.dart';
import 'package:pet_integrated/models/usertemp.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices {
  static final api_uri = dotenv.env['API_URI'];
  static Future<void> logout() async {
    try {
      // var response = await Dio().post('${api_uri}/auth/logout');
      //  debugPrint(response.toString());
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('access_token');
      await prefs.remove('user');
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> login(data) async {
    try {
      var dio = Dio();
      var payload = {
        'username': data['username'],
        'password': data['password'],
      };
      var api_uri = dotenv.env['API_URI'];
      var response = await dio.post(
        '${api_uri}/auth/login',
        data: jsonEncode(payload),
      );
      // log('${response.data['access_token']}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', response.data['access_token']);
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> getProfile() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var access_token = prefs.get('access_token');
      var api_uri = dotenv.env['API_URI'];
      var dio = Dio();

      dio.options.headers["Authorization"] = "Bearer ${access_token}";
      var response = await dio.get(
        '${api_uri}/auth/profile',
      );

      await prefs.setString('user', jsonEncode(response.data));
    } catch (e) {
      log(e.toString());
    }
  }

  static Future<void> register() async {}
}
