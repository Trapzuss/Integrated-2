import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';

class BuildCardDetail extends StatelessWidget {
  var post;
  BuildCardDetail({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 6,
      margin: EdgeInsets.only(right: 10, left: 10, top: 5),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _customCard(context, 'Sex',
              ExtensionServices.capitalize(post['sex'].toString())),
          _customCard(
            context,
            'Age',
            "${post['age']['year'].toString()} Years\n${post['age']['month'].toString()} Months",
          ),
          _customCard(context, 'Weight', "${post['weight'].toString()} Kgs"),
        ],
      ),
    );
  }
}

Widget _customCard(BuildContext context, title, text) {
  return Card(
    elevation: 0,
    color: Colors.transparent,
    child: Container(
      width: MediaQuery.of(context).size.width / 3.5,
      height: MediaQuery.of(context).size.height / 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            transform: GradientRotation(270),
            colors: [
              Color.fromARGB(255, 255, 255, 248),
              AppTheme.colors.secondaryFontColor
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          )),
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 5),
              child: Text(
                title,
                overflow: TextOverflow.fade,
                softWrap: true,
                maxLines: 2,
                textAlign: TextAlign.center,
                style: TextStyle(
                    overflow: TextOverflow.fade,
                    color: AppTheme.colors.subInfoFontColor,
                    fontSize: 12),
              ),
            ),
            Text(
              text,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colors.infoFontColor),
            )
          ],
        ),
      ), //declare your widget here
    ),
  );
}
