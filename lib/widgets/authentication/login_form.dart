import 'package:flutter/material.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/utils/theme.dart';

class loginForm extends StatefulWidget {
  var formKey = GlobalKey<FormState>();
  var controllerUsername = TextEditingController();
  var controllerPassword = TextEditingController();

  Function submitForm;
  loginForm(
      {Key? key,
      required this.formKey,
      required this.controllerUsername,
      required this.controllerPassword,
      required this.submitForm})
      : super(key: key);

  @override
  State<loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  String? _usernameRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'username is required';
    } else if (value != null && value.contains('@')) {
      return 'Do not use the @ char.';
    }
  }

  String? _passwordRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'password is required';
    } else if (value != null && value.contains('@')) {
      return 'Do not use the @ char.';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
        key: widget.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                validator: _usernameRules,
                controller: widget.controllerUsername,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Enter Username",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                validator: _passwordRules,
                controller: widget.controllerPassword,
                obscureText: true,
                decoration: InputDecoration(
                  filled: true,
                  labelText: "Enter Password",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.blue,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25.0),
                    borderSide: BorderSide(
                      color: Colors.white,
                      width: 2.0,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  widget.submitForm(context);
                },
                icon: Icon(Icons.arrow_right),
                label: Text('Sign in'),
                style: ButtonStyle(
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18.0),
                ))),
              ),
            ),
            Container(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => DefaultLayout()));
                },
                icon: Icon(Icons.person),
                label: Text('Continue as guest'),
                style: ButtonStyle(
                    foregroundColor: MaterialStateProperty.all<Color>(
                        AppTheme.colors.primary),
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side: BorderSide(color: AppTheme.colors.primary)))),
              ),
            ),
          ],
        ));
  }
}
