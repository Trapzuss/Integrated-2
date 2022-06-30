import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/posts/build_adoptdetail.dart';
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
  bool _guest = true;
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
      setState(() {
        _guest = false;
      });
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
    // print(_guest);
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
              adoptStatusComputedWidget(),
              BuildTitle(post: widget.post),
              BuildCardDetail(post: widget.post),
              BuildContactDetail(
                  post: widget.post,
                  isOwner: _isOwner,
                  isGuest: _guest,
                  isAdopted: widget.post?['adoptedBy'] != null),
              BuildDetails(post: widget.post),
              (widget.post?['adoptedBy'] != null) && _isOwner
                  ? BuildPostAdoptDetail(post: widget.post)
                  : Container()
            ],
          ),
        ),
      ),
    );
  }

  adoptStatusComputedWidget() {
    if (widget.post?['adoptedBy'] != null) {
      return Container(
        margin: EdgeInsets.only(bottom: 10, top: 10),
        width: MediaQuery.of(context).size.width - 20,
        padding: EdgeInsets.only(top: 12, bottom: 12, left: 10, right: 10),
        decoration: BoxDecoration(
          color: Colors.green[300],
          borderRadius: BorderRadius.circular(10),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.green,
          //     blurRadius: 10,
          //   )
          // ]
        ),
        child: Text(
          'This post was adopted.'.toUpperCase(),
          textAlign: TextAlign.center,
          style: AppTheme.style.primaryFontStyle
              .copyWith(fontSize: 18, color: Colors.white),
        ),
      );
    }
    return Container();
  }
}
