import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/posts/generate/build_post_form.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GeneratePostScreen extends StatefulWidget {
  const GeneratePostScreen({Key? key}) : super(key: key);

  @override
  State<GeneratePostScreen> createState() => _GeneratePostScreenState();
}

class _GeneratePostScreenState extends State<GeneratePostScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  var _formKey = GlobalKey<FormState>();
  var _controllerTitle = TextEditingController();
  var _controllerDescription = TextEditingController();
  var _controllerPetname = TextEditingController();
  var _controllerSex = TextEditingController();
  var _controllerAge = TextEditingController();
  var _controllerWeight = TextEditingController();
  var _controllerDistrict = TextEditingController();
  var _controllerProvince = TextEditingController();
  var _controllerCountry = TextEditingController();
  var _controllerPrice = TextEditingController();
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
        print('Valid');
        PostServices.createPost(context, payload);
      } else {
        print('isNotValid');
        print(_formKey.currentContext);
      }
    } catch (e) {
      debugPrint(e.toString());
    }
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
                  child: Text('Post'),
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
              scaffoldKey: _scaffoldKey,
              formKey: _formKey,
              controllerTitle: _controllerTitle,
              controllerAge: _controllerAge,
              controllerCountry: _controllerCountry,
              controllerDescription: _controllerDescription,
              controllerDistrict: _controllerDistrict,
              controllerPetname: _controllerPetname,
              controllerPrice: _controllerPrice,
              controllerProvince: _controllerProvince,
              controllerSex: _controllerSex,
              controllerWeight: _controllerWeight,
              pickImageAction: pickImage,
              getGeneralInfoAction: getGeneralInfo,
              getAddressInfoAction: getAddressInfo,
              getCostInfoAction: getCostInfo),
        ),
      ),
    );
  }
}
