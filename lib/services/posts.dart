import 'dart:convert';
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

class PostServices {
  static final api_uri =
      Platform.isWindows ? dotenv.env['API_URI_WEB'] : dotenv.env['API_URI'];
  static Future<void> createPost(context, post) async {
    var isLoading = BotToast.showLoading();
    var mediaFile = post['images'][0];
    UploadTask? task;
    if (post == null) return isLoading();
    final fileName = '${basename(mediaFile!.path)}${DateTime.now()}';
    final destination = "files/$fileName";
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic user = prefs.get('user');
      var userMap = jsonDecode(user) as Map<String, dynamic>;
      // #upload file to storage
      task = FirebaseApi.uploadFile(destination, mediaFile!);
      if (task == null) return isLoading();
      final snapshot = await task.whenComplete(() {});
      final urlDownload = await snapshot.ref.getDownloadURL();

      var district = '';
      var province = '';
      var country = '';
      // #check address
      if (post['address']['district'] == -1) {
        district = userMap['address']['district'];
        province = userMap['address']['province'];
        country = userMap['address']['country'];
      } else {
        district = post['address']['district'];
        province = post['address']['province'];
        country = post['address']['country'];
      }

      var payload = {
        "userId": userMap['_id'],
        "petName": post['petName'],
        "images": [urlDownload],
        "address": {
          "district": district,
          "province": province,
          "country": country,
        },
        "description": post['description'],
        "sex": post['sex'],
        "age": post['age'],
        "weight": post['weight'],
        "price": post['price'],
      };
      // print(payload);

      var response = await Dio().post('${api_uri}/posts', data: payload);
      // debugPrint(response.toString());

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
        subtitle: (_) => Text('Created post successfully'),
        title: (_) => const Text(
          'Successfully',
          style: TextStyle(color: Colors.white),
        ),
      );
      Navigator.popUntil(context, (route) => route.isFirst);
      //  Navigator.pop(context);
    } catch (e) {
      debugPrint(e.toString());
      await FirebaseApi.deleteTask(destination);
    } finally {
      isLoading();
    }
  }

  static Future<void> updatePost(context, post) async {
    var isLoading = BotToast.showLoading();
    var mediaFile = post?['images']?[0];
    var fileName;
    var destination;
    UploadTask? task;
    if (post == null) throw Error();
    if (mediaFile?.runtimeType != String) {
      fileName = '${basename(mediaFile!.path)}${DateTime.now()}';
      destination = "files/$fileName";
    }

    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      dynamic user = prefs.get('user');
      var userMap = jsonDecode(user) as Map<String, dynamic>;
      // #upload file to storage

      if (mediaFile?.runtimeType != String) {
        task = FirebaseApi.uploadFile(destination, mediaFile!);
        if (task == null) return isLoading();
        final snapshot = await task.whenComplete(() {});
        final urlDownload = await snapshot.ref.getDownloadURL();
      }

      // #check address
      var district = '';
      var province = '';
      var country = '';
      if (post?['address']?['district'] == null ||
          post?['address']?['district'] == -1) {
        district = userMap?['address']?['district'];
        province = userMap?['address']?['province'];
        country = userMap?['address']?['country'];
      } else {
        district = post?['address']?['district'];
        province = post?['address']?['province'];
        country = post?['address']?['country'];
      }

      var payload = {
        "userId": userMap['_id'],
        "petName": post['petName'],
        "images": post['images'],
        "address": {
          "district": district,
          "province": province,
          "country": country,
        },
        "description": post['description'],
        "sex": post['sex'],
        "age": post['age'],
        "weight": post['weight'],
        "price": post['price'],
      };
      // print(payload);

      var response =
          await Dio().patch('${api_uri}/posts/${post['_id']}', data: payload);

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
        subtitle: (_) => Text('Posted has been Updated'),
        title: (_) => const Text(
          'Updated!',
          style: TextStyle(color: Colors.white),
        ),
      );
      Navigator.pop(context, true);
    } catch (e) {
      debugPrint(e.toString());
      // await FirebaseApi.deleteTask(destination);
      isLoading();
    } finally {
      isLoading();
    }
  }

  static Future<void> deletePost(context, postId) async {
    try {
      var response = await Dio().delete('${api_uri}/posts/${postId}');
      // debugPrint(response.toString());
      BotToast.showNotification(
        crossPage: true,
        backgroundColor: Colors.red[400],
        leading: (cancel) => SizedBox.fromSize(
            size: const Size(40, 40),
            child: IconButton(
              icon: Icon(Icons.delete, color: Colors.white),
              onPressed: cancel,
            )),
        duration: Duration(seconds: 3),
        subtitle: (_) => Text('Post has been deleted.'),
        title: (_) => const Text(
          'Deleted',
          style: TextStyle(color: Colors.white),
        ),
      );
      Navigator.pop(context, true);
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future getPostByPostId(String postId) async {
    try {
      var response = await Dio().get('${api_uri}/posts/${postId}');
      // debugPrint(response.toString());
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future getPosts(String userId) async {
    try {
      if (userId != null) {
        return await getPostsComputed(userId);
      }

      var response = await Dio().get('${api_uri}/posts');

      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future getPostsComputed(String userId) async {
    try {
      // print(api_uri);
      var response = await Dio().get('${api_uri}/posts/computed/$userId');

      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future getPostsByUserId(String userId) async {
    try {
      var response = await Dio().get('${api_uri}/posts?userId=$userId');
      // debugPrint(response.toString());
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future getPostsByKeyword(String keyword) async {
    try {
      var response = await Dio().get('${api_uri}/posts?keyword=$keyword');
      // debugPrint(response.toString());
      return response.data;
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
