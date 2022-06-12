import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/mixins/authentication.dart';
import 'package:pet_integrated/screens/auth/register_screen.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/screens/profile/profile_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/authentication/login_form.dart';
import 'package:pet_integrated/widgets/authentication/registration_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _controllerUsername = TextEditingController();
  final _controllerPassword = TextEditingController();

  @override
  void dispose() {
    _controllerUsername.dispose();
    _controllerPassword.dispose();

    super.dispose();
  }

  Future<void> _submitForm(context) async {
    try {
      final isValid = _formKey.currentState!.validate();
      if (isValid) {
        var payload = {
          'username': _controllerUsername.text,
          'password': _controllerPassword.text,
        };

        await AuthenticationServices.login(payload);
        await AuthenticationServices.getProfile();

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Processing Data')),
        );

        await Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => DefaultLayout()));
      } else
        return;
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
              margin: EdgeInsets.only(top: 32, left: 10, right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Container(
                      width: width * 0.3,
                      height: height * 0.3,
                      child: CircleAvatar(
                        backgroundColor: AppTheme.colors.primary,
                        foregroundColor: AppTheme.colors.notWhite,
                        child: Icon(
                          Icons.pets,
                          size: 54,
                        ),
                      ),
                    ),
                  ]),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    Text(
                      'Pethome',
                      style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.colors.primary),
                    ),
                  ]),
                  Text(
                    'Sign In',
                    textAlign: TextAlign.left,
                    style: AppTheme.style.titleFontStyle,
                  ),
                  loginForm(
                      formKey: _formKey,
                      controllerUsername: _controllerUsername,
                      controllerPassword: _controllerPassword,
                      submitForm: _submitForm),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Not registered?',
                        style: AppTheme.style.secondaryFontStyle,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegisterScreen()));
                        },
                        child: Text(
                          'Create an register',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.colors.decorateColor),
                        ),
                      ),
                    ],
                  )
                ],
              )),
        ));
  }
}
