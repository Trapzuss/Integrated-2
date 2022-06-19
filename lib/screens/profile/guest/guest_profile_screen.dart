import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/services/users.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/profile/profile_header.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GuestProfileScreen extends StatefulWidget {
  var userId;
  GuestProfileScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<GuestProfileScreen> createState() => _GuestProfileScreenState();
}

class _GuestProfileScreenState extends State<GuestProfileScreen> {
  // var _user;

  // @override
  // void initState() {
  //   super.initState();
  // }

  // Future<void> initialUserData() async {
  //   var temp = await UserServices.getUserById(widget.userId);
  //   _user = temp[0];
  // }

  // Future _refreshData() async {
  //   await initialUserData();
  // }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: UserServices.getUserById(widget.userId, true),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return LoadingWidget();
          }
          if (snapshot.hasError) {
            return EmptyPostsTypeError(
              error: snapshot.error.toString(),
            );
          }
          if (snapshot.hasData) {
            var temp = snapshot.data as List;
            var user = temp[0];
            return Scaffold(
                appBar: AppBar(
                  backgroundColor: AppTheme.colors.notWhite,
                  title: Text(
                    user['firstName'] + ' ' + user['lastName'],
                    overflow: TextOverflow.fade,
                  ),
                ),
                body: Container(
                  margin: EdgeInsets.only(
                    left: 10,
                    right: 10,
                  ),
                  child: ProfileHeader(
                    user: user,
                    action: () {},
                    isGuest: true,
                  ),
                ));
          }
          return EmptyPostsTypeEmpty();
        });
  }
}
