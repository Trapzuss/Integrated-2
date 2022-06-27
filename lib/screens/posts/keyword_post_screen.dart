import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/home/post_grid_view.dart';

class KeywordPostScreen extends StatefulWidget {
  var posts;
  String keyword;
  KeywordPostScreen({Key? key, required this.posts, required this.keyword})
      : super(key: key);

  @override
  State<KeywordPostScreen> createState() => _KeywordPostScreenState();
}

class _KeywordPostScreenState extends State<KeywordPostScreen> {
  Future _refreshPosts() async {
    await PostServices.getPosts(AuthenticationServices.getUserId().toString());
    setState(() {});
    // print('refresh success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.keyword),
          elevation: 0,
          backgroundColor: AppTheme.colors.notWhite,
        ),
        body: Container(
            margin: EdgeInsets.only(right: 10, left: 10),
            child: PostGridView(
                posts: widget.posts, refreshPosts: _refreshPosts)));
  }
}
