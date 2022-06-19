import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/services/users.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/profile/edits/edit_image.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({Key? key}) : super(key: key);

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  var _user;
  File? _mediaFile;
  final _controllerFirstname = TextEditingController();
  final _controllerLastname = TextEditingController();
  final _controllerDistrict = TextEditingController();
  final _controllerProvince = TextEditingController();
  final _controllerCountry = TextEditingController();

  void _pickImage(newMedia) async {
    try {
      setState(() {
        this._mediaFile = File(newMedia.path);
        // this.uploadFile = newMedia;
      });
    } catch (e) {
      print(e.toString());
    }
  }

  String? _firstnameRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Firstname is required';
    }
    if (value != null && value.length > 30) {
      return 'Firstname is too long';
    } else {
      return null;
    }
  }

  String? _lastnameRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lastname is required';
    }
    if (value != null && value.length > 30) {
      return 'Lastname is too long';
    } else {
      return null;
    }
  }

  String? _districtRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'City is required';
    } else {
      return null;
    }
  }

  String? _provinceRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Province is required';
    } else {
      return null;
    }
  }

  String? _countryRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required';
    } else {
      return null;
    }
  }

  _submitForm() async {
    try {
      var payload = {
        'imageUrl': _mediaFile,
        'firstName': _controllerFirstname.text,
        'lastName': _controllerLastname.text,
        'address': {
          'district': _controllerDistrict.text,
          'province': _controllerProvince.text,
          'country': _controllerCountry.text,
        }
      };
      // print(payload);
      await UserServices.updateProfile(context, payload);
    } catch (e) {
      print(e.toString());
    }
  }

  _intitialProfileData() async {
    _user = await AuthenticationServices.getProfileFromState();

    _controllerFirstname.text = _user['firstName'];
    _controllerLastname.text = _user['lastName'];
    _controllerDistrict.text = _user?['address']?['district'] == null
        ? ''
        : _user['address']['district'];
    _controllerProvince.text = _user?['address']?['province'] == null
        ? ''
        : _user['address']['province'];
    _controllerCountry.text = _user?['address']?['country'] == null
        ? ''
        : _user['address']['country'];
    // print(_user);
  }

  @override
  void initState() {
    _intitialProfileData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppTheme.colors.notWhite,
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            color: AppTheme.colors.notWhite,
            height: double.infinity,
            width: double.infinity,
            padding: EdgeInsets.only(top: 115, left: 20, right: 20),
            margin: EdgeInsets.only(bottom: 20),
            child: SingleChildScrollView(
              child: _profileForm(
                context,
                _controllerFirstname,
                _controllerLastname,
                _controllerDistrict,
                _controllerProvince,
                _controllerCountry,
                _user,
                _submitForm,
              ),
            ),
          ),
          // Container(
          //   height: 180,
          //   color: AppTheme.colors.notWhite,
          // ),
          Container(
            width: double.infinity,
            height: 100,
            margin: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            decoration: BoxDecoration(
                color: Color(0xfff6f6f6),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.colors.primaryShade,
                    blurRadius: 0.8,
                    offset: Offset(0, 4),
                  )
                ]),
            child: Container(
              margin: EdgeInsets.only(
                top: 10,
              ),
              child: Column(
                children: [
                  ProfileImageEditing(
                    imageUrl:
                        _user?['imageUrl'] == null ? null : _user['imageUrl'],
                    pickImageAction: _pickImage,
                  ),
                  Text('Tap to change profile picture',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12,
                      )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _profileForm(
      context,
      controllerFirstname,
      controllerLastname,
      controllerDistrict,
      controllerProvince,
      controllerCountry,
      user,
      submitForm) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.symmetric(vertical: 5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 4),
                  child: Text(
                    'Firstname',
                    style: AppTheme.style.secondaryFontStyle,
                  ),
                ),
                TextFormField(
                  validator: _firstnameRules,
                  controller: controllerFirstname,
                  style: TextStyle(color: Colors.black),
                  decoration: AppTheme.style.textFieldStyle(
                      hinttext: 'Firstname', prefixIcon: Icon(Icons.person)),
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(30),
                  ],
                ),
              ],
            )),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  'Lastname',
                  style: AppTheme.style.secondaryFontStyle,
                ),
              ),
              TextFormField(
                validator: _lastnameRules,
                controller: controllerLastname,
                style: TextStyle(color: Colors.black),
                decoration: AppTheme.style.textFieldStyle(
                    hinttext: 'Surename', prefixIcon: Icon(Icons.person)),
                inputFormatters: [
                  LengthLimitingTextInputFormatter(30),
                ],
              ),
            ],
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.symmetric(vertical: 5),
        //   child: TextFormField(
        //     style: TextStyle(color: Colors.black),
        //     decoration: AppTheme.style.textFieldStyle(
        //         hinttext: 'Email', prefixIcon: Icon(Icons.email)),
        //   ),
        // ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  'District',
                  style: AppTheme.style.secondaryFontStyle,
                ),
              ),
              TextFormField(
                validator: _districtRules,
                controller: controllerDistrict,
                style: TextStyle(color: Colors.black),
                decoration: AppTheme.style.textFieldStyle(
                    hinttext: 'District', prefixIcon: Icon(Icons.home)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  'Province',
                  style: AppTheme.style.secondaryFontStyle,
                ),
              ),
              TextFormField(
                validator: _provinceRules,
                controller: controllerProvince,
                style: TextStyle(color: Colors.black),
                decoration: AppTheme.style.textFieldStyle(
                    hinttext: 'Province', prefixIcon: Icon(Icons.location_on)),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 5),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 4),
                child: Text(
                  'Country',
                  style: AppTheme.style.secondaryFontStyle,
                ),
              ),
              TextFormField(
                validator: _countryRules,
                controller: controllerCountry,
                style: TextStyle(color: Colors.black),
                decoration: AppTheme.style.textFieldStyle(
                    hinttext: 'Country', prefixIcon: Icon(Icons.flag)),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 55,
          width: double.infinity,
          // decoration: BoxDecoration(
          //   boxShadow: [
          //     BoxShadow(
          //       color: Color.fromARGB(90, 20, 20, 20),
          //       blurRadius: 10,
          //       offset: Offset(6, 6),
          //     ),
          //   ],
          // ),
          child: SizedBox(
            child: ElevatedButton(
              child: Text("Save Changes"),
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(18.0),
              ))),
              onPressed: () {
                submitForm();
              },
            ),
          ),
        )
      ],
    );
  }
}
