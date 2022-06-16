import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/home/post_card.dart';

class PostGridView extends StatefulWidget {
  List posts;
  PostGridView({Key? key, required this.posts}) : super(key: key);

  @override
  State<PostGridView> createState() => _PostGridViewState();
}

class _PostGridViewState extends State<PostGridView> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      itemCount: widget.posts.length,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      // shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          child: PostCard(post: widget.posts[index]),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PostScreen(post: widget.posts[index]);
            }));
          },
        );
      },
    );
  }
}
