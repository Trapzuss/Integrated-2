import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/home/post_grid_view.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key, required this.keyword}) : super(key: key);
  String keyword;
  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  Future _refreshPosts() async {
    await PostServices.getPostsByKeyword(widget.keyword);
    setState(() {});
    // print('refresh success');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          widget.keyword,
          style: TextStyle(color: AppTheme.colors.notWhite),
        ),
      ),
      body: FutureBuilder(
          future: PostServices.getPostsByKeyword(widget.keyword),
          builder: ((context, snapshot) {
            if (snapshot.connectionState != ConnectionState.done) {
              return Center(
                  child: CircularProgressIndicator(
                color: AppTheme.colors.primary,
              ));
            }
            if (snapshot.hasError) {
              return EmptyPostsTypeError(error: snapshot.error.toString());
            }

            if (snapshot.hasData) {
              final List posts = snapshot.data as List;

              return Container(
                margin: EdgeInsets.only(
                  left: 10,
                  right: 10,
                ),
                child: RefreshIndicator(
                  color: AppTheme.colors.primary,
                  backgroundColor: Colors.white,
                  onRefresh: () async {
                    // print('refresh');
                    await _refreshPosts();
                    return Future.delayed(Duration(seconds: 1));
                  },
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Container(
                          margin: EdgeInsets.only(top: 5),
                          child: PostGridView(
                              posts: posts, refreshPosts: _refreshPosts)),
                    ]),
                  ),
                ),
              );
            }

            return EmptyPostsTypeEmpty();
          })),
    );
  }
}
