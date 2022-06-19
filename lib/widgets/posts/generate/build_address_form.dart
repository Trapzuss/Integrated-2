import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildAddressForm extends StatefulWidget {
  var post;
  var controllerDistrict = TextEditingController();
  var controllerProvince = TextEditingController();
  var controllerCountry = TextEditingController();
  var getAddressInfoAction;
  BuildAddressForm(
      {Key? key,
      this.post,
      required this.controllerDistrict,
      required this.controllerProvince,
      required this.controllerCountry,
      required this.getAddressInfoAction})
      : super(key: key);

  @override
  State<BuildAddressForm> createState() => _BuildAddressFormState();
}

class _BuildAddressFormState extends State<BuildAddressForm> {
  bool _useMyLocation = true;

  @override
  void initState() {
    _initialPostData();
    super.initState();
  }

  void _initialPostData() {
    if (widget.post != null) {
      if (widget.controllerCountry.text.toLowerCase() ==
              widget.post?['address']?['country'].toString().toLowerCase() &&
          widget.controllerDistrict.text.toLowerCase() ==
              widget.post?['address']?['district'].toString().toLowerCase() &&
          widget.controllerProvince.text.toLowerCase() ==
              widget.post?['address']?['province'].toString().toLowerCase()) {
        _useMyLocation = true;
      } else {
        _useMyLocation = false;
      }
    }
  }

  String? _districtRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill out the district';
    }
  }

  String? _provinceRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill out the province';
    }
  }

  String? _countryRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill out the country';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
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
          //     decoration: AppTheme.style.textFieldStyle(hinttext: 'Street'),
          //   ),
          // ),

          Container(
            margin: EdgeInsets.only(bottom: 5),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(15)),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Text(
                          'Use my location',
                          style: AppTheme.style.bodyFontStyle,
                        ))),
                Flexible(
                    child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Switch(
                            value: _useMyLocation,
                            onChanged: (value) {
                              onSwitchAddressChange(value);
                            }))),
              ],
            ),
          ),
          !_useMyLocation
              ? Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Row(
                        children: [
                          Flexible(
                              child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: TextFormField(
                              validator: _useMyLocation ? null : _districtRules,
                              controller: widget.controllerDistrict,
                              decoration: AppTheme.style
                                  .textFieldStyle(hinttext: 'District'),
                            ),
                          )),
                          Flexible(
                              child: Container(
                            margin: EdgeInsets.only(right: 5),
                            child: TextFormField(
                              validator: _useMyLocation ? null : _provinceRules,
                              controller: widget.controllerProvince,
                              decoration: AppTheme.style
                                  .textFieldStyle(hinttext: 'Province'),
                            ),
                          )),
                          Flexible(
                            child: Container(
                              margin: EdgeInsets.only(bottom: 5),
                              child: Row(
                                children: [
                                  // Flexible(
                                  //     child: Container(
                                  //   margin: EdgeInsets.only(right: 5),
                                  //   child: TextFormField(
                                  //       decoration:
                                  //           AppTheme.style.textFieldStyle(hinttext: 'Zip code'),
                                  //       keyboardType: TextInputType.number),
                                  // )),
                                  Flexible(
                                      child: Container(
                                    margin: EdgeInsets.only(right: 5),
                                    child: TextFormField(
                                      validator:
                                          _useMyLocation ? null : _countryRules,
                                      controller: widget.controllerCountry,
                                      decoration: AppTheme.style
                                          .textFieldStyle(hinttext: 'Country'),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  onSwitchAddressChange(value) {
    setState(() {
      _useMyLocation = value;
    });

    if (!_useMyLocation) {
      var payload = {
        "district": widget.controllerDistrict.text,
        "province": widget.controllerProvince.text,
        "country": widget.controllerCountry.text
      };
      widget.getAddressInfoAction(payload);
    } else {
      print(_useMyLocation);
      var payload = {"district": -1, "province": -1, "country": -1};
      widget.getAddressInfoAction(payload);
    }
  }
}
