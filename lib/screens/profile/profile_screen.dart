import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/screens/profile/profile_edit_screen.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/screens/auth/login_screen.dart';
import 'package:pet_integrated/screens/auth/register_screen.dart';
import 'package:pet_integrated/widgets/profile/profile_body.dart';
import 'package:pet_integrated/widgets/profile/profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  var _access_token = '';
  var _isLogin = false;
  var _user = null;

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
        _access_token = access_token as String;
        _user = userMap;
        _isLogin = true;
      });
    }
  }

  Future _refreshData() async {
    await AuthenticationServices.getProfile();
    await initialUserData();
  }

  _navigateToEditProfile() async {
    bool? _refresh = await Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => ProfileEditScreen()));
    // print('profile');
    // print(_refresh);
    if (_refresh != null && _refresh) {
      await _refreshData();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      child: SingleChildScrollView(
        child: Column(
          children: [
            ProfileHeader(user: _user, action: _navigateToEditProfile),
            _isLogin ? ProfileBody() : Container(),
          ],
        ),
      ),
    );
  }
}
