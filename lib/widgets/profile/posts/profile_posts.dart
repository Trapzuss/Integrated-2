import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/home/post_card.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfilePostGridView extends StatefulWidget {
  const ProfilePostGridView({Key? key}) : super(key: key);

  @override
  State<ProfilePostGridView> createState() => _ProfilePostGridViewState();
}

class _ProfilePostGridViewState extends State<ProfilePostGridView> {
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
        _user = userMap;
      });
      // print(_user);
      // print(_user['firstName']);
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Container(
        child: _user == null
            ? CircularProgressIndicator(
                color: AppTheme.colors.primary,
              )
            : FutureBuilder(
                future: PostServices.getPostsByUserId(_user['_id']),
                builder: ((context, snapshot) {
                  if (snapshot.hasError) {
                    return EmptyPostsTypeError(
                        error: snapshot.error.toString());
                  } else if (snapshot.hasData) {
                    final List posts = snapshot.data as List;
                    // if (posts.isEmpty) {
                    //   return EmptyPostsTypeEmpty();
                    // \}
                    return MasonryGridView.count(
                      shrinkWrap: true,
                      crossAxisCount: 2,
                      itemCount: posts.length,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 6,
                      // shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: PostCard(post: posts[index]),
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return PostScreen(
                                post: posts[index],
                              );
                            }));
                          },
                        );
                      },
                    );
                  } else {
                    return Center(
                        child: CircularProgressIndicator(
                      color: AppTheme.colors.primary,
                    ));
                  }
                })));
  }
}
