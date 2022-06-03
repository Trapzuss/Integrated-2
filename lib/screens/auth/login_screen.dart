import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pet_integrated/widgets/authentication/registration_form.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerDisplayName = TextEditingController();

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerPassword.dispose();
    _controllerDisplayName.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    try {
      var payload = {
        'userDisplayName': _controllerDisplayName.text,
        'username': _controllerUsername.text,
        'password': _controllerPassword.text,
      };
      if (_formKey.currentState!.validate()) {
        var response = await Dio().post('http://10.0.2.2:3000/auth/register',
            data: jsonEncode(payload));
        log(response.statusCode.toString());
        // if (response.statusCode == 200) {
        //   log(response.toString());
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Processing Data')),
        //   );
        // } else {
        //   log(response.toString());
        // }
      }
    } catch (e) {
      log(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: Container(
              margin: EdgeInsets.only(top: 32),
              child: registrationForm(
                  formKey: _formKey,
                  controllerUsername: _controllerUsername,
                  controllerPassword: _controllerPassword,
                  controllerDisplayName: _controllerDisplayName,
                  submitForm: _submitForm)),
        ));
  }
}
