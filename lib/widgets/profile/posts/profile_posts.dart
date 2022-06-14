import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/widgets/home/post_card.dart';

class ProfilePostGridView extends StatelessWidget {
  const ProfilePostGridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List posts = ['1', '2', '3'];
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return MasonryGridView.count(
      shrinkWrap: true,
      crossAxisCount: 2,
      itemCount: posts.length,
      mainAxisSpacing: 6,
      crossAxisSpacing: 6,
      // shrinkWrap: true,
      itemBuilder: (context, index) {
        return InkWell(
          child: PostCard(),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return PostScreen();
            }));
          },
        );
      },
    );
  }
}
