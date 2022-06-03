import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/posts/build_cards_detail.dart';
import 'package:pet_integrated/widgets/posts/build_contact_detail.dart';
import 'package:pet_integrated/widgets/posts/build_details.dart';
import 'package:pet_integrated/widgets/posts/build_image.dart';
import 'package:pet_integrated/widgets/posts/build_titledetail.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({Key? key}) : super(key: key);

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        // appBar: AppBar(
        //   backgroundColor: AppTheme.colors.notWhite,
        //   elevation: 0,
        // ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BuildImage(),
                BuildTitle(),
                BuildCardDetail(),
                BuildContactDetail(),
                BuildDetails()
              ],
            ),
          ),
        ));
  }
}
