import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:pet_integrated/services/firebase.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserServices {
  static final api_uri =
      Platform.isWindows ? dotenv.env['API_URI_WEB'] : dotenv.env['API_URI'];

  static Future<void> updateProfile(context, data) async {
    var isLoading = BotToast.showLoading();

    try {
      var urlDownload;
      var mediaFile = data['imageUrl'];
      UploadTask? task;
      if (data == null) return isLoading();

      if (mediaFile.runtimeType != String && mediaFile != null) {
        final fileName = '${basename(mediaFile!.path)}${DateTime.now()}';
        final destination = "files/$fileName";
        // #upload file to storage
        task = FirebaseApi.uploadFile(destination, mediaFile!);
        if (task == null) return isLoading();
        final snapshot = await task.whenComplete(() {});
        urlDownload = await snapshot.ref.getDownloadURL();
      }
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic user = prefs.get('user');
      var userMap = jsonDecode(user) as Map<String, dynamic>;

      var payload = {
        ...data,
        "imageUrl": urlDownload == null ? userMap['imageUrl'] : urlDownload
      };
      // log("$payload");
      var response =
          await Dio().patch("${api_uri}/user/${userMap['_id']}", data: payload);
      await prefs.setString('user', jsonEncode({...userMap, ...payload}));

      BotToast.showNotification(
        crossPage: true,
        backgroundColor: Colors.green[400],
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.check, color: Colors.white),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 3),
        subtitle: (_) => Text('Profile has been Updated'),
        title: (_) => const Text(
          'Updated!',
          style: TextStyle(color: Colors.white),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      BotToast.showNotification(
        crossPage: true,
        backgroundColor: Colors.red[400],
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.error, color: Colors.white),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 3),
        subtitle: (_) => Text('Sorry, Please try again later.'),
        title: (_) => const Text(
          'Something went wrong!',
          style: TextStyle(color: Colors.white),
        ),
      );
      print(e.toString());
      isLoading();
    } finally {
      isLoading();
    }
  }

  static Future getUserById(String userId, bool post) async {
    var isLoading = BotToast.showLoading();
    try {
      var response = await Dio().get(
        "${api_uri}/user/$userId${post ? "?post=true" : ""}",
      );
      return response.data;
    } catch (e) {
      isLoading();
      print(e.toString());
    } finally {
      isLoading();
    }
  }

  static Future uploadImage(_mediaFile) async {
    String fileName = "${_mediaFile!.path.split('/').last}${DateTime.now()}";
    FormData formData = FormData.fromMap({
      "file":
          await MultipartFile.fromFile(_mediaFile!.path, filename: fileName),
    });
    log(formData.toString());
    var response =
        await Dio().post("${UserServices.api_uri}/upload", data: formData);
    log(response.data);
  }
}
