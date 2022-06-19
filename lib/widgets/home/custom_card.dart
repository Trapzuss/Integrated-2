import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class CustomCard extends StatelessWidget {
  CustomCard(
      {Key? key, required this.name, required this.src, required this.action})
      : super(key: key);
  final String name;
  final String src;
  final action;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.41,
          margin: EdgeInsets.only(top: 5, bottom: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                child: Image.asset(
                  src,
                  fit: BoxFit.cover,
                ),
                backgroundColor: Colors.transparent,
                foregroundColor: AppTheme.colors.primary,
              ),
              Container(
                margin: EdgeInsets.only(right: 10, left: 10),
                child: Text(
                  name,
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colors.infoFontColor),
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        action();
      },
    );
  }
}
