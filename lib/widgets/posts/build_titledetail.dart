import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildTitle extends StatelessWidget {
  var post;
  BuildTitle({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(bottom: 5),
                child: Text(
                  post['petName'],
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.colors.infoFontColor),
                ),
              ),
              Row(
                children: [
                  Icon(Icons.location_on_rounded, color: Colors.red[300]),
                  Text(
                    "${post['address']['district']} ${post['address']['province']}, ${post['address']['country']}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.colors.subInfoFontColor),
                  ),
                ],
              )
            ],
          ),
          Text(
            post['price'] == 0 ? "Free" : post['price'].toString(),
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppTheme.colors.infoFontColor),
          )
        ],
      ),
    );
  }
}
