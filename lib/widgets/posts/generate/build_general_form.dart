import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_picker/flutter_picker.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildGeneralForm extends StatefulWidget {
  const BuildGeneralForm({Key? key, required this.scaffoldKey})
      : super(key: key);
  final GlobalKey<ScaffoldState> scaffoldKey;

  @override
  State<BuildGeneralForm> createState() => _BuildGeneralFormState();
}

class _BuildGeneralFormState extends State<BuildGeneralForm> {
  String _selectedItem = 'Sex';

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
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: TextFormField(
              decoration:
                  AppTheme.style.textFieldStyle(hinttext: 'Enter your title'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: TextFormField(
              decoration: AppTheme.style
                  .textFieldStyle(hinttext: 'Enter your description'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: TextFormField(
              decoration: AppTheme.style
                  .textFieldStyle(hinttext: 'Enter your pet name'),
            ),
          ),
          Row(
            children: [
              // TODO flutter picker
              Flexible(
                  child: Container(
                margin: EdgeInsets.only(right: 5),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      // side: BorderSide(color: Colors.black, width: 1),
                      borderRadius: BorderRadius.circular(25)),
                  title: Text(
                    _selectedItem,
                    style: AppTheme.style.secondaryFontStyle,
                  ),
                  onTap: _onButtonPressed,
                ),
                //  TextFormField(
                //   decoration: AppTheme.style
                //       .textFieldStyle(hinttext: 'Enter your pet sex'),
                // ),
              )),
              Flexible(
                  child: Container(
                margin: EdgeInsets.only(right: 5),
                child: TextFormField(
                    decoration: AppTheme.style.textFieldStyle(hinttext: 'Age'),
                    keyboardType: TextInputType.number),
              )),
              Flexible(
                  child: Container(
                margin: EdgeInsets.only(right: 5),
                child: TextFormField(
                    decoration:
                        AppTheme.style.textFieldStyle(hinttext: 'Weight'),
                    keyboardType: TextInputType.number),
              )),
            ],
          )
        ],
      ),
    );
  }

  void _onButtonPressed() {
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
                    leading: Icon(Icons.ac_unit),
                    title: Text('Male'),
                    onTap: () {
                      _selectItem('Male');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.ac_unit),
                    title: Text('Female'),
                    onTap: () {
                      _selectItem('Female');
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.ac_unit),
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

  void _selectItem(String name) {
    Navigator.pop(context);
    setState(() {
      _selectedItem = name;
    });
  }
}
