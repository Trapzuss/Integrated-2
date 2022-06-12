import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/widgets/posts/generate/build_address_form.dart';
import 'package:pet_integrated/widgets/posts/generate/build_cost_form.dart';
import 'package:pet_integrated/widgets/posts/generate/build_general_form.dart';
import 'package:pet_integrated/widgets/posts/generate/build_post_image.dart';

class BuildPostForm extends StatefulWidget {
  const BuildPostForm({Key? key, required this.scaffoldKey}) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;
  @override
  State<BuildPostForm> createState() => _BuildPostFormState();
}

class _BuildPostFormState extends State<BuildPostForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10),
      child: Form(
          child: Column(
        children: [
          BuildPostImage(),
          BuildGeneralForm(scaffoldKey: widget.scaffoldKey),
          BuildAddressForm(),
          BuildCostForm()
        ],
      )),
    );
  }
}
