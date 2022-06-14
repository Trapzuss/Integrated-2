import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/posts/generate/build_post_form.dart';

class GeneratePostScreen extends StatefulWidget {
  const GeneratePostScreen({Key? key}) : super(key: key);

  @override
  State<GeneratePostScreen> createState() => _GeneratePostScreenState();
}

class _GeneratePostScreenState extends State<GeneratePostScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  var _controllerUsername = TextEditingController();
  var _controllerPassword = TextEditingController();
  var _controllerDisplayName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.notWhite,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            SizedBox(
                height: 30,
                width: 80,
                child: ElevatedButton(
                  child: Text('Post'),
                  onPressed: () {},
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BuildPostForm(scaffoldKey: _scaffoldKey),
        ),
      ),
    );
  }
}
