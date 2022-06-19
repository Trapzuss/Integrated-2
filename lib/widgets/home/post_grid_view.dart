import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/home/post_card.dart';

class PostGridView extends StatefulWidget {
  List posts;
  var refreshPosts;
  PostGridView({Key? key, required this.posts, required this.refreshPosts})
      : super(key: key);

  @override
  State<PostGridView> createState() => _PostGridViewState();
}

class _PostGridViewState extends State<PostGridView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return widget.posts.length != 0
        ? MasonryGridView.count(
            physics: NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            itemCount: widget.posts.length,
            mainAxisSpacing: 6,
            crossAxisSpacing: 6,
            // shrinkWrap: true,
            itemBuilder: (context, index) {
              return InkWell(
                child: PostCard(post: widget.posts[index]),
                onTap: () async {
                  bool? _refresh = await Navigator.push(context,
                      MaterialPageRoute(builder: (context) {
                    return PostScreen(post: widget.posts[index]);
                  }));
                  // TODO refresh
                  print('gridview');
                  print(_refresh);
                  if (_refresh == true) {
                    widget.refreshPosts();
                  }
                },
              );
            },
          )
        : EmptyPostsTypeEmpty();
  }
}
