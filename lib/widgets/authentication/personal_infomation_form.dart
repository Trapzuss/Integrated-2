import 'package:flutter/material.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/utils/theme.dart';

class PersonalInfomationForm extends StatefulWidget {
  var formKey = GlobalKey<FormState>();
  var controllerEmail = TextEditingController();
  var controllerPassword = TextEditingController();
  var controllerFirstname = TextEditingController();
  var controllerLastname = TextEditingController();

  PersonalInfomationForm(
      {Key? key,
      required this.formKey,
      required this.controllerEmail,
      required this.controllerPassword,
      required this.controllerFirstname,
      required this.controllerLastname})
      : super(key: key);

  @override
  State<PersonalInfomationForm> createState() => _PersonalInfomationFormState();
}

class _PersonalInfomationFormState extends State<PersonalInfomationForm> {
  String? _firstnameRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Firstname is required';
    } else {
      return null;
    }
  }

  String? _lastnameRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Lastname is required';
    } else {
      return null;
    }
  }

  String? _emailRules(String? value) {
    bool emailValid = RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(value!);
    if (value == null || value.isEmpty) {
      return 'Email is required';
    } else if (!emailValid) {
      return 'Email is not valid';
    } else {
      return null;
    }
  }

  String? _passwordRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Form(
      key: widget.formKey,
      child: Container(
        margin: EdgeInsets.only(bottom: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  height: height / 3.5,
                  margin: EdgeInsets.only(bottom: 5),
                  child: Image.asset('assets/images/Profile-pic-pana.png'),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'Personal Infomation',
                style: AppTheme.style.primaryFontStyle,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Flexible(
                      child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: TextFormField(
                      validator: _firstnameRules,
                      controller: widget.controllerFirstname,
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'Firstname'),
                    ),
                  )),
                  Flexible(
                      child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: TextFormField(
                      validator: _lastnameRules,
                      controller: widget.controllerLastname,
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'Lastname'),
                    ),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: TextFormField(
                validator: _emailRules,
                controller: widget.controllerEmail,
                decoration: AppTheme.style.textFieldStyle(
                    hinttext: 'Email', prefixIcon: Icon(Icons.email)),
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: TextFormField(
                validator: _passwordRules,
                controller: widget.controllerPassword,
                obscureText: true,
                decoration: AppTheme.style.textFieldStyle(
                    hinttext: 'Password', prefixIcon: Icon(Icons.lock)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
