import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:pet_integrated/layouts/default_layout.dart';

import 'package:pet_integrated/screens/auth/login_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationServices {
  static final api_uri =
      Platform.isWindows ? dotenv.env['API_URI_WEB'] : dotenv.env['API_URI'];
  static Future<void> logout(context) async {
    try {
      AwesomeDialog(
        context: context,
        dialogType: DialogType.WARNING,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Log out from AdoptHome?',
        // desc: 'Dialog description here.............',
        btnOkText: "Log out",
        btnCancelText: "Cancel",
        buttonsTextStyle: TextStyle(color: AppTheme.colors.notWhite),
        btnCancelColor: AppTheme.colors.darkFontColor,
        btnOkColor: Colors.red,
        btnOkOnPress: () async {
          var response = await Dio().post('${api_uri}/auth/logout');
          var cancel = BotToast.showLoading();
          // debugPrint(response.toString());
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.remove('access_token');
          await prefs.remove('user');
          cancel();
          BotToast.showNotification(
            crossPage: true,
            backgroundColor: Colors.red[400],
            leading: (cancel) => SizedBox.fromSize(
                size: const Size(40, 40),
                child: IconButton(
                  icon: Icon(Icons.logout, color: Colors.white),
                  onPressed: cancel,
                )),
            duration: Duration(seconds: 3),
            title: (_) => const Text(
              'Logged out',
              style: TextStyle(color: Colors.white),
            ),
          );

          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => LoginScreen()));
        },
        btnCancelOnPress: () {
          return;
        },
      )..show();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> login(
    context,
    data,
  ) async {
    try {
      // print(data);

      var response = await Dio().post(
        '${api_uri}/auth/login',
        data: jsonEncode(data),
      );
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', response.data['access_token']);
      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Login successfully',
        desc: 'Welcome to AdoptHome.',
        btnOkOnPress: () {},
      )..show();
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).popUntil((route) => route.isFirst);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DefaultLayout()));
      });
    } catch (e) {
      if (e is DioError) {
        // log("${e.response?.data}");
        var error = e.response?.data;
        // log("${error?['error']}");
        AwesomeDialog(
          context: context,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          title: 'Something went wrong!',
          desc: error?['error'],
          btnOkOnPress: () {},
        )..show();
      } else {
        log("is error");
      }
    }
  }

  static Future<void> register(
    context,
    data,
  ) async {
    try {
      var response =
          await Dio().post('${api_uri}/auth/register', data: jsonEncode(data));

      AwesomeDialog(
        context: context,
        dialogType: DialogType.SUCCES,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Register successfully',
        desc: 'Please sign in to continue AdoptHome.',
        btnOkOnPress: () {},
      )..show();
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => LoginScreen()));
      });
    } catch (e) {
      log(e.toString());
      AwesomeDialog(
        context: context,
        dialogType: DialogType.ERROR,
        animType: AnimType.BOTTOMSLIDE,
        title: 'Something went wrong!',
        desc: 'Please try again later.',
        btnOkOnPress: () {},
      )..show();
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

  static Future checkAuthenState() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      var user = prefs.get('user');
      if (user == null) {
        return false;
      }
      return true;
    } catch (e) {
      print(e.toString());
    }
  }

  static Future getProfileFromState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var access_token = prefs.get('access_token');
    dynamic user = prefs.get('user');
    Map<String, dynamic> userMap = {};
    if (user != null) {
      // print(user);
    }
    if (access_token != null) {
      userMap = jsonDecode(user) as Map<String, dynamic>;
      return userMap;
    }
  }

  static Future getUserId() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic user = prefs.get('user');
      Map<String, dynamic> userMap = {};
      userMap = jsonDecode(user) as Map<String, dynamic>;
      return userMap['_id'];
    } catch (e) {
      print(e.toString());
    }
  }
}
