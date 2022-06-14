import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/screens/auth/login_screen.dart';
import 'package:pet_integrated/screens/auth/register_screen.dart';
import 'package:pet_integrated/widgets/profile/profile_body.dart';
import 'package:pet_integrated/widgets/profile/profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
            // ElevatedButton(
            //     onPressed: () async {
            //       await AuthenticationServices.getProfile();
            //     },
            //     child: Text('get profile')),
            // !_isLogin
            //     ? ElevatedButton(
            //         onPressed: () {
            //           Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => LoginScreen()));
            //         },
            //         child: Text('Login'))
            //     : ElevatedButton(
            //         onPressed: () {
            //           AuthenticationServices.logout();
            //           setState(() {
            //             _isLogin = false;
            //           });
            //           Navigator.pushReplacement(
            //               context,
            //               MaterialPageRoute(
            //                   builder: (context) => DefaultLayout()));
            //         },
            //         style: ButtonStyle(
            //           backgroundColor:
            //               MaterialStateProperty.all<Color>(Colors.red),
            //         ),
            //         child: Text('Logout')),
            // Text('_access_token:${_access_token}'),
            // Text('username:${_username}'),
            ProfileHeader(user: _user),
            ProfileBody(),
          ],
        ),
      ),
    );
  }
}
