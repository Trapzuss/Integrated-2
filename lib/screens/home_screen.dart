import 'package:flutter/material.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/home/custom_card.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
        InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => PostScreen()));
          },
          child: Card(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              child: CircleAvatar(
                child: Icon(Icons.abc_outlined),
                backgroundColor: Colors.transparent,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
