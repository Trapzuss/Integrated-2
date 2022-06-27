import 'dart:convert';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/services/firebase.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatServices {
  static final api_uri =
      Platform.isWindows ? dotenv.env['API_URI_WEB'] : dotenv.env['API_URI'];
  static final chat_api_uri = Platform.isWindows
      ? dotenv.env['CHAT_API_URI_WEB']
      : dotenv.env['CHAT_API_URI'];

  static getChatList() async {
    try {
      var userId = await AuthenticationServices.getUserId();

      var response = await Dio().get('${api_uri}/chats?userId=$userId');
      return response.data;
    } catch (e) {
      print(e.toString());
    }
  }
}
