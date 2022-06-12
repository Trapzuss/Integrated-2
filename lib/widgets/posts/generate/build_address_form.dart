import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildAddressForm extends StatefulWidget {
  const BuildAddressForm({Key? key}) : super(key: key);

  @override
  State<BuildAddressForm> createState() => _BuildAddressFormState();
}

class _BuildAddressFormState extends State<BuildAddressForm> {
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
          Container(
            margin: EdgeInsets.only(bottom: 5),
            child: TextFormField(
              decoration: AppTheme.style.textFieldStyle(hinttext: 'Street'),
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
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'City'),
                      keyboardType: TextInputType.number),
                )),
                Flexible(
                    child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: TextFormField(
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'Province'),
                      keyboardType: TextInputType.number),
                )),
              ],
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
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'Zip code'),
                      keyboardType: TextInputType.number),
                )),
                Flexible(
                    child: Container(
                  margin: EdgeInsets.only(right: 5),
                  child: TextFormField(
                      decoration:
                          AppTheme.style.textFieldStyle(hinttext: 'Country'),
                      keyboardType: TextInputType.number),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
