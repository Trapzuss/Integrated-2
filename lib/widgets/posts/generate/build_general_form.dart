import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildGeneralForm extends StatefulWidget {
  const BuildGeneralForm({Key? key}) : super(key: key);

  @override
  State<BuildGeneralForm> createState() => _BuildGeneralFormState();
}

class _BuildGeneralFormState extends State<BuildGeneralForm> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
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
                child: TextFormField(
                  decoration: AppTheme.style
                      .textFieldStyle(hinttext: 'Enter your pet sex'),
                ),
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
}
