import 'package:flutter/material.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/posts/keyword_post_screen.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/home/custom_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_integrated/widgets/home/post_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future _refreshPosts() async {
    await PostServices.getPosts();
    setState(() {});
    // print('refresh success');
  }

  Future _navigateToKeywordScreen(String keyword) async {
    // print('yo');
    var posts = await PostServices.getPostsByKeyword(keyword);
    print(posts);
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return KeywordPostScreen(posts: posts, keyword: keyword);
    }));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PostServices.getPosts(),
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
              child: SingleChildScrollView(
                  child: RefreshIndicator(
                onRefresh: () async {
                  // print('refresh');
                  await _refreshPosts();
                  return Future.delayed(Duration(seconds: 1));
                },
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                          name: 'Dogs',
                          src: AppTheme.src.dogImage,
                          action: () {
                            _navigateToKeywordScreen('dog');
                          }),
                      CustomCard(
                          name: 'Cats',
                          src: AppTheme.src.catImage,
                          action: () {
                            _navigateToKeywordScreen('cat');
                          }),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      child: PostGridView(
                          posts: posts, refreshPosts: _refreshPosts)),
                ]),
              )),
            );
          }

          return EmptyPostsTypeEmpty();
        }));
  }
}
