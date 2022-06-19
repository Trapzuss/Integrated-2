import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/screens/profile/guest/guest_profile_screen.dart';
import 'package:pet_integrated/screens/profile/profile_screen.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildContactDetail extends StatelessWidget {
  var post;
  BuildContactDetail({Key? key, required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10, left: 10, top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/Dogpaw-pana.png'),
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
                          "${post['user'][0]['firstName']} ${post['user'][0]['lastName']}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.colors.infoFontColor),
                        ),
                      ),
                      Text(
                        "Pet's owner",
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
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return GuestProfileScreen(userId: post['userId']);
              }));
            },
          ),
          Container(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Container(
                //   margin: EdgeInsets.only(right: 5),
                //   width: 35,
                //   child: ElevatedButton(
                //       onPressed: () {},
                //       child: Icon(
                //         Icons.call,
                //       ),
                //       style: ElevatedButton.styleFrom(
                //           padding: EdgeInsets.all(0),
                //           elevation: 0,
                //           shape: CircleBorder())),
                // ),
                Container(
                  width: 35,
                  child: ElevatedButton(
                      onPressed: () {},
                      child: Icon(
                        Icons.chat,
                        size: 16,
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.all(0),
                          elevation: 0,
                          shape: CircleBorder())),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
