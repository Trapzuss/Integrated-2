import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/screens/auth/login_screen.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/screens/profile/profile_screen.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/authentication/registration_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
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

  Future<void> _submitForm(context) async {
    try {
      var payload = {
        'username': _controllerUsername.text,
        'password': _controllerPassword.text,
      };

      var api_uri = dotenv.env['API_URI'];
      log('${api_uri}');
      var response =
          await Dio().post('${api_uri}/auth/login', data: jsonEncode(payload));
      // log(response.statusCode.toString());

      log('${response.data['access_token']}');
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('access_token', response.data['access_token']);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Processing Data')),
      );
      print('successfully');
      await Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => DefaultLayout()));
      // var payload = {
      //   'userDisplayName': _controllerDisplayName.text,
      //   'username': _controllerUsername.text,
      //   'password': _controllerPassword.text,
      // };
      // if (_formKey.currentState!.validate()) {
      //   var api_uri = dotenv.env['API_URI'];
      //   log('${api_uri}');
      //   var response = await Dio()
      //       .post('${api_uri}/auth/register', data: jsonEncode(payload));
      //   // log(response.statusCode.toString());
      //   if (response.statusCode == 200) {
      //     SharedPreferences prefs = await SharedPreferences.getInstance();
      //     prefs.setString('email', _controllerUsername.text);
      //     // log(response.toString());
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Processing Data')),
      //     );
      //   } else {
      //     log(response.toString());
      //   }
      // }
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
            child: SafeArea(
          child: Container(
            margin: EdgeInsets.only(top: 10, left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Sign In',
                  style: AppTheme.style.titleFontStyle,
                ),
                Container(
                    child: registrationForm(
                        formKey: _formKey,
                        controllerUsername: _controllerUsername,
                        controllerPassword: _controllerPassword,
                        controllerDisplayName: _controllerDisplayName,
                        submitForm: _submitForm)),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Already have an account?',
                      style: AppTheme.style.secondaryFontStyle,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => LoginScreen()));
                      },
                      child: Text(
                        "Let's sign in",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.colors.decorateColor),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        )));
  }
}
