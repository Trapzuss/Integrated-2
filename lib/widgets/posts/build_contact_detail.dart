import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/screens/chat/chat_screen.dart';
import 'package:pet_integrated/screens/profile/guest/guest_profile_screen.dart';
import 'package:pet_integrated/screens/profile/profile_screen.dart';
import 'package:pet_integrated/utils/theme.dart';

class BuildContactDetail extends StatelessWidget {
  var post;
  bool isOwner;
  bool isGuest;
  bool isAdopted;
  BuildContactDetail(
      {Key? key,
      required this.post,
      required this.isOwner,
      required this.isGuest,
      required this.isAdopted})
      : super(key: key);

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
                post['user']?['imageUrl'] != null
                    ? CircleAvatar(
                        backgroundImage:
                            NetworkImage("${post['user']?['imageUrl']}"),
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
                          "${post['user']['firstName']} ${post['user']['lastName']}",
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppTheme.colors.infoFontColor),
                        ),
                      ),
                      Text(
                        "Post's owner",
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
          (isOwner == false && isGuest == false) && isAdopted == false
              ? Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        width: 35,
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => ChatScreen(
                                          toUser:
                                              post?['chat']?['toUser'] ?? null,
                                          chatId: post?['chat']?['_id'] ?? null,
                                          post: post,
                                          user: post['user'])));
                            },
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
              : Container()
        ],
      ),
    );
  }
}
