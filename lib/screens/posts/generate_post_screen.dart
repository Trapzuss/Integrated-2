import 'dart:io';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/posts/generate/build_post_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneratePostScreen extends StatefulWidget {
  String action;
  var post;
  GeneratePostScreen({Key? key, required this.action, this.post})
      : super(key: key);

  @override
  State<GeneratePostScreen> createState() => _GeneratePostScreenState();
}

class _GeneratePostScreenState extends State<GeneratePostScreen> {
  var _post;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  // var _controllerTitle = TextEditingController();
  final _controllerDescription = TextEditingController();
  final _controllerPetname = TextEditingController();
  // var _controllerSex = TextEditingController();
  // var _controllerAge = TextEditingController();
  // var _controllerWeight = TextEditingController();
  final _controllerDistrict = TextEditingController();
  final _controllerProvince = TextEditingController();
  final _controllerCountry = TextEditingController();
  final _controllerPrice = TextEditingController();
  File? _mediaFile;
  var generalInfo;
  var addressInfo;
  var costInfo;
  void pickImage(newMedia) {
    setState(() {
      this._mediaFile = File(newMedia.path);
      // this.uploadFile = newMedia;
    });
  }

  // age weight sex
  void getGeneralInfo(data) {
    setState(() {
      generalInfo = data;
    });
  }

  void getAddressInfo(data) {
    setState(() {
      addressInfo = data;
    });
  }

  void getCostInfo(data) {
    setState(() {
      costInfo = data;
    });
  }

  Future _submitForm() async {
    try {
      // #create post
      if (widget.action != 'edit') {
        var payload = {
          "petName": _controllerPetname.text,
          "images": [_mediaFile],
          "address": {
            "district":
                addressInfo?['district'] != null ? addressInfo['district'] : -1,
            "province":
                addressInfo?['province'] != null ? addressInfo['province'] : -1,
            "country":
                addressInfo?['country'] != null ? addressInfo['country'] : -1,
          },
          "description": _controllerDescription.text,
          "sex": generalInfo['sex'],
          "age": generalInfo['age'],
          "weight": generalInfo['weight'],
          "price": costInfo?['price'] != null ? costInfo['price'] : 0,
        };
        // print(payload);
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          // print('Valid');
          PostServices.createPost(context, payload);
        } else {
          BotToast.showNotification(
            crossPage: true,
            backgroundColor: Colors.amber[400],
            leading: (cancel) => SizedBox.fromSize(
                size: const Size(40, 40),
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: cancel,
                )),
            duration: Duration(seconds: 3),
            title: (_) => const Text(
              'Please fill out all required fields.',
              style: TextStyle(color: Colors.white),
            ),
            // subtitle: (_) => Text('Please fill out all required fields.'),
          );
          print(_formKey.currentContext);
        }
      }
      // #edit post
      if (widget.action == 'edit') {
        var payload = {
          "_id": widget.post['_id'],
          "petName": _controllerPetname.text,
          "images": [_mediaFile],
          "address": {
            "district":
                addressInfo?['district'] != null ? addressInfo['district'] : -1,
            "province":
                addressInfo?['province'] != null ? addressInfo['province'] : -1,
            "country":
                addressInfo?['country'] != null ? addressInfo['country'] : -1,
          },
          "description": _controllerDescription.text,
          "sex": generalInfo['sex'],
          "age": generalInfo['age'],
          "weight": generalInfo['weight'],
          "price": costInfo?['price'] != null ? costInfo['price'] : 0,
        };
        // print(payload);
        final isValid = _formKey.currentState!.validate();
        if (isValid) {
          PostServices.updatePost(context, payload);
        } else {
          BotToast.showNotification(
            crossPage: true,
            backgroundColor: Colors.amber[400],
            leading: (cancel) => SizedBox.fromSize(
                size: const Size(40, 40),
                child: IconButton(
                  icon: Icon(Icons.delete, color: Colors.white),
                  onPressed: cancel,
                )),
            duration: Duration(seconds: 3),
            title: (_) => const Text(
              'Please fill out all required fields.',
              style: TextStyle(color: Colors.white),
            ),
            // subtitle: (_) => Text('Please fill out all required fields.'),
          );
          print(_formKey.currentContext);
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  void initState() {
    _post = widget.post;
    super.initState();
  }

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
                  child: Text(widget.action == 'edit' ? 'Edit' : 'Post'),
                  onPressed: () async {
                    await _submitForm();
                  },
                )),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: BuildPostForm(
              post: _post,
              scaffoldKey: _scaffoldKey,
              formKey: _formKey,
              // controllerTitle: _controllerTitle,
              // controllerAge: _controllerAge,
              controllerCountry: _controllerCountry,
              controllerDescription: _controllerDescription,
              controllerDistrict: _controllerDistrict,
              controllerPetname: _controllerPetname,
              controllerPrice: _controllerPrice,
              controllerProvince: _controllerProvince,
              // controllerSex: _controllerSex,
              // controllerWeight: _controllerWeight,
              pickImageAction: pickImage,
              getGeneralInfoAction: getGeneralInfo,
              getAddressInfoAction: getAddressInfo,
              getCostInfoAction: getCostInfo),
        ),
      ),
    );
  }
}
