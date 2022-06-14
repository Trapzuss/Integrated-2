import 'dart:convert';
import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/screens/auth/login_screen.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/screens/profile/profile_screen.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/authentication/address_form.dart';
import 'package:pet_integrated/widgets/authentication/overview_form.dart';
import 'package:pet_integrated/widgets/authentication/personal_infomation_form.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:bot_toast/bot_toast.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formPersonalKey = GlobalKey<FormState>();
  final _formAddressKey = GlobalKey<FormState>();

  final _controllerEmail = TextEditingController();
  final _controllerPassword = TextEditingController();
  final _controllerFirstname = TextEditingController();
  final _controllerLastname = TextEditingController();
  // final _controllerStreet = TextEditingController();
  final _controllerDistrict = TextEditingController();
  final _controllerProvince = TextEditingController();
  // final _controllerZipcode = TextEditingController();
  final _controllerCountry = TextEditingController();

  var _overviewData = {};

  int _currentStep = 0;

  @override
  void dispose() {
    _controllerEmail.dispose();
    _controllerPassword.dispose();
    _controllerFirstname.dispose();
    _controllerLastname.dispose();
    // _controllerStreet.dispose();
    _controllerDistrict.dispose();
    _controllerProvince.dispose();
    // _controllerZipcode.dispose();
    _controllerCountry.dispose();
    super.dispose();
  }

  Future<void> _submitForm(context) async {
    try {
      var api_uri = dotenv.env['API_URI'];
      var payload = {
        "email": _controllerEmail.text,
        "firstName": _controllerFirstname.text,
        "lastName": _controllerLastname.text,
        "address": {
          // "street": _controllerStreet.text,
          "district": _controllerDistrict.text,
          "province": _controllerProvince.text,
          // "zipCode": _controllerZipcode.text,
          "country": _controllerCountry.text
        },
        "password": _controllerPassword.text
      };

      if (_formAddressKey.currentState!.validate() &&
          _formPersonalKey.currentState!.validate()) {
        await AuthenticationServices.register(payload, context);
      }
    } catch (e) {
      log(e.toString());
    }
  }

  _onSubmitPersonalForm() {
    if (_formPersonalKey.currentState!.validate()) {
      _formPersonalKey.currentState!.save();
      setState(() {
        _currentStep++;
      });
    }
  }

  _onSubmitAddress() {
    if (_formAddressKey.currentState!.validate()) {
      _formAddressKey.currentState!.save();
      setState(() {
        _currentStep++;
      });
    }
  }

  void retrievedData() {
    // print('retrievedData');
    setState(() {
      _overviewData = {
        'email': _controllerEmail.text,
        'password': _controllerPassword.text,
        'firstname': _controllerFirstname.text,
        'lastname': _controllerLastname.text,
        // 'street': _controllerStreet.text,
        'city': _controllerDistrict.text,
        'province': _controllerProvince.text,
        // 'zipcode': _controllerZipcode.text,
        'country': _controllerCountry.text,
      };
    });
    // print(_overviewData);
  }

  _stepState(int step) {
    if (_currentStep > step) {
      return StepState.complete;
    } else {
      return StepState.editing;
    }
  }

  _steps() => [
        Step(
          title: const Text('Personal'),
          content: PersonalInfomationForm(
            formKey: _formPersonalKey,
            controllerEmail: _controllerEmail,
            controllerPassword: _controllerPassword,
            controllerFirstname: _controllerFirstname,
            controllerLastname: _controllerLastname,
          ),
          state: _stepState(0),
          isActive: _currentStep == 0,
        ),
        Step(
          title: const Text('Address'),
          content: AddressForm(
            formKey: _formAddressKey,
            // controllerStreet: _controllerStreet,
            controllerDistrict: _controllerDistrict,
            controllerProvince: _controllerProvince,
            // controllerZipcode: _controllerZipcode,
            controllerCountry: _controllerCountry,
          ),
          state: _stepState(1),
          isActive: _currentStep == 1,
        ),
        Step(
          title: const Text('Overview'),
          content: overviewForm(data: _overviewData),
          state: _stepState(2),
          isActive: _currentStep == 2,
        )
      ];

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          'Register',
          style: TextStyle(color: AppTheme.colors.notWhite),
        ),
      ),
      body: SafeArea(
        child: Container(
            child: Stepper(
                elevation: 0,
                type: StepperType.horizontal,
                onStepTapped: (step) {
                  if (step == 2) {
                    // print('is go to overview');
                    if (_formPersonalKey.currentState!.validate() &&
                        _formAddressKey.currentState!.validate()) {
                      retrievedData();
                      setState(() => _currentStep = step);
                    }
                  }
                  if (_currentStep == 0) {
                    if (_formPersonalKey.currentState!.validate()) {
                      setState(() => _currentStep = step);
                    }
                  } else if (_currentStep == 1) {
                    if (_formAddressKey.currentState!.validate()) {
                      setState(() => _currentStep = step);
                    }
                  } else {
                    setState(() => _currentStep = step);
                  }
                },
                onStepContinue: () {
                  if (_currentStep + 1 == 2) {
                    // print('is go to overview');
                    retrievedData();
                  }
                  if (_currentStep == 0) {
                    _onSubmitPersonalForm();
                  } else if (_currentStep == 1) {
                    _onSubmitAddress();
                  } else {
                    setState(() {
                      if (_currentStep < _steps().length - 1) {
                        _currentStep += 1;
                      } else {
                        _submitForm(context);
                      }
                    });
                  }
                },
                onStepCancel: () {
                  setState(() {
                    if (_currentStep > 0) {
                      _currentStep -= 1;
                    } else {
                      _currentStep = 0;
                    }
                  });
                },
                currentStep: _currentStep,
                steps: _steps(),
                controlsBuilder:
                    (BuildContext context, ControlsDetails controls) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        _currentStep != 0
                            ? Container(
                                child: InkWell(
                                  onTap: controls.onStepCancel,
                                  child: const Text(
                                    'BACK',
                                    style: TextStyle(color: Colors.grey),
                                  ),
                                ),
                              )
                            : Spacer(),
                        ElevatedButton(
                          onPressed: controls.onStepContinue,
                          child: Text(_currentStep != 2 ? 'NEXT' : 'REGISTER'),
                          style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                        ),
                      ],
                    ),
                  );
                })),
      ),
    );
  }
}
