import 'package:flutter/material.dart';
import 'package:pet_integrated/common/empty_widget.dart';
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
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: PostServices.getPosts(),
        builder: ((context, snapshot) {
          if (snapshot.hasError) {
            return EmptyPostsTypeError(error: snapshot.error.toString());
          } else if (snapshot.hasData) {
            final List posts = snapshot.data as List;
            // if (posts.isEmpty) {
            //   return EmptyPostsTypeEmpty();
            // }
            return Container(
              margin: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: SingleChildScrollView(
                child: Column(children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomCard(
                        name: 'Dogs',
                      ),
                      CustomCard(
                        name: 'Cats',
                      ),
                    ],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      child: PostGridView(posts: posts))
                ]),
              ),
            );
          } else {
            return Center(
                child: CircularProgressIndicator(
              color: AppTheme.colors.primary,
            ));
          }
        }));
  }
}
