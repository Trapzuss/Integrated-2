import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/posts/build_cards_detail.dart';
import 'package:pet_integrated/widgets/posts/build_contact_detail.dart';
import 'package:pet_integrated/widgets/posts/build_details.dart';
import 'package:pet_integrated/widgets/posts/build_image.dart';
import 'package:pet_integrated/widgets/posts/build_titledetail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PostScreen extends StatefulWidget {
  var post;

  PostScreen({Key? key, required this.post}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  var _user = null;
  bool _isOwner = false;
  @override
  initState() {
    initialUserData();
    super.initState();
  }

  Future<void> initialUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var access_token = prefs.get('access_token');
    dynamic user = prefs.get('user');
    Map<String, dynamic> userMap = {};
    if (user != null) {
      userMap = jsonDecode(user) as Map<String, dynamic>;
    }

    if (access_token != null) {
      // print('is set');
      setState(() {
        _user = userMap;
      });
      // print(_user);
      // print(_user['firstName']);
    }
    if (_user?['_id'] == widget.post?['user']?['_id']) {
      setState(() {
        _isOwner = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: AppTheme.colors.notWhite,
        //   elevation: 0,
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildImage(post: widget.post, user: _user, isOwner: _isOwner),
                BuildTitle(post: widget.post),
                BuildCardDetail(post: widget.post),
                BuildContactDetail(post: widget.post),
                BuildDetails(post: widget.post)
              ],
            ),
          ),
        ));
  }
}
