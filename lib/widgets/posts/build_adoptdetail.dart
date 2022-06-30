import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/widgets.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';

class BuildPostAdoptDetail extends StatelessWidget {
  var post;
  BuildPostAdoptDetail({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 4, bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: width - 20,
            margin: EdgeInsets.only(bottom: 4),
            child: Text(
              'Adopted Detail',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.colors.infoFontColor),
            ),
          ),
          Row(
            children: [
              post['adoptedUser']?['imageUrl'] != null
                  ? CircleAvatar(
                      backgroundImage:
                          NetworkImage("${post['adoptedUser']?['imageUrl']}"),
                      backgroundColor: Colors.white,
                    )
                  : CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: AppTheme.colors.darkFontColor,
                      ),
                      backgroundColor: Colors.white,
                    ),
              Container(
                width: MediaQuery.of(context).size.width / 2.5,
                margin: EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(bottom: 5),
                      child: Text(
                        "${post['adoptedUser']['firstName']} ${post['adoptedUser']['lastName']}",
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: AppTheme.colors.infoFontColor),
                      ),
                    ),
                    Text(
                      "Adopted user",
                      overflow: TextOverflow.fade,
                      softWrap: true,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          overflow: TextOverflow.fade,
                          color: AppTheme.colors.subInfoFontColor,
                          fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.only(top: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Adopted At',
                  textAlign: TextAlign.start,
                  style: AppTheme.style.primaryFontStyle,
                ),
                Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(right: 4),
                      child: Text(
                        ExtensionServices.convertTimestampToDate(
                            post['adoptedAt']),
                        textAlign: TextAlign.start,
                        style: AppTheme.style.primaryFontStyle,
                      ),
                    ),
                    Text(
                      ExtensionServices.convertTimestampToTime(
                          post['adoptedAt']),
                      textAlign: TextAlign.start,
                      style: AppTheme.style.primaryFontStyle,
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
