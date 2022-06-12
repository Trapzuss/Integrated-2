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
  var formKey = GlobalKey<FormState>();
  var controllerUsername = TextEditingController();
  var controllerPassword = TextEditingController();
  var controllerDisplayName = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.notWhite,
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BuildPostForm(),
        ),
      ),
    );
  }
}
