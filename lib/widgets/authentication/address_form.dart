import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_integrated/utils/theme.dart';

class AddressForm extends StatefulWidget {
  var formKey = GlobalKey<FormState>();
  // var controllerStreet = TextEditingController();
  var controllerDistrict = TextEditingController();
  var controllerProvince = TextEditingController();
  // var controllerZipcode = TextEditingController();
  var controllerCountry = TextEditingController();

  AddressForm(
      {Key? key,
      required this.formKey,
      // required this.controllerStreet,
      required this.controllerDistrict,
      required this.controllerProvince,
      // required this.controllerZipcode,
      required this.controllerCountry})
      : super(key: key);

  @override
  State<AddressForm> createState() => _Address_formtate();
}

class _Address_formtate extends State<AddressForm> {
  // String? _streetRules(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Street is required';
  //   } else {
  //     return null;
  //   }
  // }

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

  // String? _zipcodeRules(String? value) {
  //   if (value == null || value.isEmpty) {
  //     return 'Zipcode is required';
  //   } else {
  //     return null;
  //   }
  // }

  String? _countryRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Country is required';
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
                  child: Image.asset('assets/images/Address-rafiki.png'),
                ),
              ],
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                'Address Infomation',
                style: AppTheme.style.primaryFontStyle,
              ),
            ),
            // Container(
            //   margin: EdgeInsets.only(bottom: 5),
            //   child: TextFormField(
            //     validator: _streetRules,
            //     controller: widget.controllerStreet,
            //     decoration: AppTheme.style.textFieldStyle(hinttext: 'Street'),
            //   ),
            // ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  Flexible(
                      child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: TextFormField(
                      validator: _districtRules,
                      controller: widget.controllerDistrict,
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'District'),
                    ),
                  )),
                  Flexible(
                      child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: TextFormField(
                      validator: _provinceRules,
                      controller: widget.controllerProvince,
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'Province'),
                    ),
                  )),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Row(
                children: [
                  // Flexible(
                  //     child: Container(
                  //   margin: EdgeInsets.only(right: 5),
                  //   child: TextFormField(
                  //       validator: _zipcodeRules,
                  //       controller: widget.controllerZipcode,
                  //       decoration:
                  //           AppTheme.style.textFieldStyle(hinttext: 'Zip code'),
                  //       keyboardType: TextInputType.number),
                  // )),
                  Flexible(
                      child: Container(
                    margin: EdgeInsets.only(right: 5),
                    child: TextFormField(
                      validator: _countryRules,
                      controller: widget.controllerCountry,
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'Country'),
                    ),
                  )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
