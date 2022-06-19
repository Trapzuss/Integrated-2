import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';

class BuildGeneralForm extends StatefulWidget {
  var post;
  // var controllerTitle = TextEditingController();
  var controllerDescription = TextEditingController();
  var controllerPetname = TextEditingController();
  // var controllerSex = TextEditingController();
  // var controllerAge = TextEditingController();
  // var controllerWeight = TextEditingController();
  var getGeneralInfoAction;

  BuildGeneralForm({
    Key? key,
    this.post,
    required this.scaffoldKey,
    required this.getGeneralInfoAction,
    // required this.controllerTitle,
    required this.controllerDescription,
    required this.controllerPetname,
    // required this.controllerSex,
    // required this.controllerAge,
    // required this.controllerWeight,
  }) : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<BuildGeneralForm> createState() => _BuildGeneralFormState();
}

class _BuildGeneralFormState extends State<BuildGeneralForm> {
  var weightIndex = [0];
  var ageIndex = [0, 0];
  var generalInfo;
  var sexIcons = {
    'Female': Icons.female,
    'Male': Icons.male,
    'Unknown': Icons.question_mark,
  };
  String _selectedSex = 'Press to select your pet\'s sex';
  var _selectedWeight;
  var _selectedAge;
  bool _isUnknownAge = false;
  bool _isUnknownWeight = false;
  var pickerDataAge = [
    ['< 1', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, '> 10'],
    ['< 1', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12],
  ];
  var pickerDataWeight = [
    ['< 1', 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, '> 10'],
  ];

  @override
  void initState() {
    _initialPostData();
    super.initState();
  }

  void _initialPostData() {
    if (widget.post != null) {
      if (widget.post?['weight'] == null) {
        _isUnknownWeight = true;
      } else {
        _selectedWeight = widget.post?['weight'];
      }
      if (widget.post?['age'] == null) {
        _isUnknownAge = true;
      } else {
        _selectedAge = widget.post?['age'];
      }
      if (_selectedWeight != null) {
        var index = pickerDataWeight[0].indexWhere(
            (element) => element.toString() == '${_selectedWeight.toString()}');
        setState(() {
          weightIndex = [index];
        });
      }
      if (_selectedAge != null) {
        var indexY = pickerDataAge[0].indexWhere((element) =>
            element.toString() == '${_selectedAge?['year'].toString()}');
        var indexM = pickerDataAge[1].indexWhere((element) =>
            element.toString() == '${_selectedAge?['month'].toString()}');
        setState(() {
          ageIndex = [indexY, indexM];
        });
      }

      setState(() {
        _selectedSex =
            ExtensionServices.capitalize(widget.post['sex'].toString());
        generalInfo = {
          "age": widget.post?['age'],
          "weight": widget.post?['weight']
        };
      });

      // print(_selectedWeight);
      // print(_selectedAge);
    }
  }

  String? _petNameRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill out the pet\'s name';
    }
  }

  String? _descriptionRules(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please fill out the description';
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
              'General Infomation',
              style: AppTheme.style.primaryFontStyle,
            ),
          ),
          // Container(
          //   margin: EdgeInsets.only(bottom: 5),
          //   child: TextFormField(
          //     controller: widget.controllerTitle,
          //     decoration:
          //         AppTheme.style.textFieldStyle(hinttext: 'Enter your title'),
          //   ),
          // ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: TextFormField(
              validator: _petNameRules,
              controller: widget.controllerPetname,
              decoration: AppTheme.style
                  .textFieldStyle(hinttext: 'Enter your pet\'s name'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: TextFormField(
              validator: _descriptionRules,
              controller: widget.controllerDescription,
              minLines: 4,
              maxLines: 6,
              decoration: AppTheme.style.textFieldStyle(
                  hinttext: 'Enter your description (Behavior, Breed, etc.)'),
            ),
          ),

          Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: GestureDetector(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        child: _selectedSex != 'Press to select your pet\'s sex'
                            ? Icon(
                                sexIcons[_selectedSex],
                                color: AppTheme.colors.subInfoFontColor,
                              )
                            : Container()),
                    Container(
                      margin: EdgeInsets.only(right: 5, top: 15, bottom: 15),
                      child: Text(
                        '$_selectedSex',
                        style: AppTheme.style.secondaryFontStyle,
                      ),
                    )
                  ],
                ),
                onTap: () {
                  _onSelectSex();
                },
              )),
          Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !_isUnknownAge
                      ? Container(
                          margin: EdgeInsets.only(top: 15),
                          child: GestureDetector(
                            child: Text(
                              _selectedAge == null
                                  ? 'Press to select your pet\'s age (years/months)'
                                  : "${_selectedAge['year']} years ${_selectedAge['month']} months",
                              style: AppTheme.style.secondaryFontStyle,
                            ),
                            onTap: () {
                              _showPicker(context, 'age');
                            },
                          ))
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Unknown ages',
                        style: AppTheme.style.bodyFontStyle,
                      ),
                      Switch(
                          value: _isUnknownAge,
                          onChanged: (value) {
                            setState(() {
                              _isUnknownAge = value;
                            });
                            if (_isUnknownAge) {
                              generalInfo = {...generalInfo, "age": null};
                            } else {
                              generalInfo = {
                                ...generalInfo,
                                "age": _selectedAge
                              };
                            }

                            widget.getGeneralInfoAction(generalInfo);
                          })
                    ],
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.only(bottom: 5),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(15)),
              padding: EdgeInsets.only(left: 10, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  !_isUnknownWeight
                      ? Container(
                          margin: EdgeInsets.only(top: 15),
                          child: GestureDetector(
                            child: Text(
                              _selectedWeight == null
                                  ? 'Press to select your pet\'s weight (kg)'
                                  : "${_selectedWeight} kg",
                              style: AppTheme.style.secondaryFontStyle,
                            ),
                            onTap: () {
                              _showPicker(context, 'weight');
                            },
                          ))
                      : Container(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Unknown weight',
                        style: AppTheme.style.bodyFontStyle,
                      ),
                      Switch(
                          value: _isUnknownWeight,
                          onChanged: (value) {
                            setState(() {
                              _isUnknownWeight = value;
                            });

                            if (_isUnknownWeight) {
                              generalInfo = {...generalInfo, "weight": null};
                            } else {
                              generalInfo = {
                                ...generalInfo,
                                "weight": _selectedWeight
                              };
                            }

                            widget.getGeneralInfoAction(generalInfo);
                          })
                    ],
                  ),
                ],
              )),
        ],
      ),
    );
  }

  void _onSelectSex() {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
            color: Colors.transparent,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.male),
                    title: Text('Male'),
                    onTap: () {
                      _selectItem('Male');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.female),
                    title: Text('Female'),
                    onTap: () {
                      _selectItem('Female');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.question_mark),
                    title: Text('Unknown'),
                    onTap: () {
                      _selectItem('Unknown');
                    },
                  )
                ],
              ),
            ),
          );
        });
  }

  _showPicker(BuildContext context, String action) {
    var pickerData = {'weight': pickerDataWeight, 'age': pickerDataAge};
    weightIndex = [0];
    ageIndex = [0, 0];
    if (_selectedWeight != null) {
      var index = pickerDataWeight[0].indexWhere(
          (element) => element.toString() == '${_selectedWeight.toString()}');
      setState(() {
        weightIndex = [index];
      });
    }
    if (_selectedAge != null) {
      var indexY = pickerDataAge[0].indexWhere((element) =>
          element.toString() == '${_selectedAge['year'].toString()}');
      var indexM = pickerDataAge[1].indexWhere((element) =>
          element.toString() == '${_selectedAge['month'].toString()}');
      setState(() {
        ageIndex = [indexY, indexM];
      });
    }

    Picker(
        adapter: PickerDataAdapter<String>(
          pickerdata: pickerData[action],
          isArray: true,
        ),
        hideHeader: true,
        selecteds: action == 'weight' ? weightIndex : ageIndex,
        title: Text("Select $action"),
        selectedTextStyle: TextStyle(color: AppTheme.colors.primary),
        cancel: TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.cancel)),
        onConfirm: (Picker picker, List value) {
          setState(() {
            if (action == 'weight') {
              _selectedWeight = pickerData[action]![0][value[0]];
            } else {
              _selectedAge = {
                "year": pickerData[action]![0][value[0]],
                "month": pickerData[action]![1][value[1]],
              };
            }
          });

          var payload = {"age": _selectedAge, "weight": _selectedWeight};
          generalInfo == null
              ? generalInfo = payload
              : generalInfo = {...generalInfo, ...payload};

          if (_isUnknownAge) {
            generalInfo = {...generalInfo, "age": null};
          }
          if (_isUnknownWeight) {
            generalInfo = {...generalInfo, "weight": null};
          }

          widget.getGeneralInfoAction(generalInfo);
        }).showDialog(context);
  }

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedSex = name;
    });
    var sex = {"sex": name.toLowerCase()};
    generalInfo == null
        ? generalInfo = sex
        : generalInfo = {...generalInfo, ...sex};
    // print(generalInfo);
    widget.getGeneralInfoAction(generalInfo);
  }
}
