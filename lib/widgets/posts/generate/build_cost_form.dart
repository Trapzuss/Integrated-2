import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildCostForm extends StatefulWidget {
  const BuildCostForm({Key? key}) : super(key: key);

  @override
  State<BuildCostForm> createState() => _BuildCostFormState();
}

class _BuildCostFormState extends State<BuildCostForm> {
  bool _isFree = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(bottom: 10),
            child: Text(
              'Adopt infomation',
              style: AppTheme.style.primaryFontStyle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        'Free Adopt',
                        style: AppTheme.style.bodyFontStyle,
                      ))),
              Flexible(
                  child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Switch(
                          value: _isFree,
                          onChanged: (value) {
                            setState(() {
                              _isFree = value;
                            });
                          }))),
            ],
          ),
          _isFree
              ? Container()
              : Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration:
                        AppTheme.style.textFieldStyle(hinttext: 'Price'),
                  ),
                )
        ],
      ),
    );
  }
}
