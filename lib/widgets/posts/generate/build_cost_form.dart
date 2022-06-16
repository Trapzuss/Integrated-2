import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildCostForm extends StatefulWidget {
  var post;
  var controllerPrice = TextEditingController();
  var getCostInfoAction;
  BuildCostForm(
      {Key? key,
      this.post,
      required this.controllerPrice,
      required this.getCostInfoAction})
      : super(key: key);

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
              'Cost infomation',
              style: AppTheme.style.primaryFontStyle,
            ),
          ),
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
                          'Free Adopt',
                          style: AppTheme.style.bodyFontStyle,
                        ))),
                Flexible(
                    child: Container(
                        margin: EdgeInsets.only(right: 5),
                        child: Switch(
                            value: _isFree,
                            onChanged: (value) {
                              onSwitchCostChange(value);
                            }))),
              ],
            ),
          ),
          _isFree
              ? Container()
              : Container(
                  margin: EdgeInsets.only(bottom: 5),
                  child: TextFormField(
                    controller: widget.controllerPrice,
                    keyboardType: TextInputType.number,
                    decoration:
                        AppTheme.style.textFieldStyle(hinttext: 'Price'),
                  ),
                )
        ],
      ),
    );
  }

  onSwitchCostChange(value) {
    setState(() {
      _isFree = value;
    });
    if (!_isFree) {
      var payload = {
        "price": widget.controllerPrice.text,
      };
      widget.getCostInfoAction(payload);
    } else {
      var payload = {
        "price": 0,
      };
      widget.getCostInfoAction(payload);
    }
  }
}
