import 'package:flutter/material.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/utils/theme.dart';

class loginForm extends StatefulWidget {
  var formKey = GlobalKey<FormState>();
  var controllerEmail = TextEditingController();
  var controllerPassword = TextEditingController();

  Function submitForm;
  loginForm(
      {Key? key,
      required this.formKey,
      required this.controllerEmail,
      required this.controllerPassword,
      required this.submitForm})
      : super(key: key);

  @override
  State<loginForm> createState() => _loginFormState();
}

class _loginFormState extends State<loginForm> {
  String? _EmailRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value)) {
      return 'Email is invalid form';
    }
  }

  String? _passwordRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'password is required';
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
                validator: _EmailRules,
                controller: widget.controllerEmail,
                decoration: AppTheme.style.textFieldStyle(
                    hinttext: 'Enter your email',
                    prefixIcon: Icon(Icons.email)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 8),
              child: TextFormField(
                validator: _passwordRules,
                controller: widget.controllerPassword,
                obscureText: true,
                decoration: AppTheme.style.textFieldStyle(
                    hinttext: 'Enter your password',
                    prefixIcon: Icon(Icons.lock)),
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
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Container(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DefaultLayout()));
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
                              side:
                                  BorderSide(color: AppTheme.colors.primary)))),
                ),
              ),
            ),
          ],
        ));
  }
}
