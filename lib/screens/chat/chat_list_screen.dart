import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/chat/chat_screen.dart';
import 'package:pet_integrated/screens/chat/clone_chat_screen.dart';
import 'package:pet_integrated/services/authentication.dart';
import 'package:pet_integrated/services/chat.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  bool _loading = true;
  var _user;
  var _userId;
  Future<void> _initialUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic user = prefs.get('user');
    Map<String, dynamic> userMap = {};
    if (user != null) {
      userMap = jsonDecode(user) as Map<String, dynamic>;
    }
    _userId = await AuthenticationServices.getUserId();
    _user = userMap;
  }

  Future _refreshChatList() async {
    await ChatServices.getChatList();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _initialUserData().whenComplete(() {
      setState(() {
        _loading = false;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  List postsTemp = [
    {
      "_id": "62beb0743ea8b2f874d10583",
      "userId": "62b9a44873ea3188eafe2f92",
      "petName": "pharo - cat",
      "images": [
        "https://firebasestorage.googleapis.com/v0/b/integrated-ii.appspot.com/o/files%2Fimages%20(2).jpeg2022-07-01%2015%3A29%3A38.343488?alt=media&token=df8ab990-13b8-4811-ad90-7774ce6781f9"
      ],
      "address": {
        "addressId": "2d1a5415-67c8-44b8-aa25-6200eefba677",
        "district": "BangRak",
        "province": "Bangkok",
        "country": "Thailand",
        "_id": "62beb0743ea8b2f874d10584"
      },
      "description": "Can anyone pet she for a while. \n",
      "sex": "female",
      "age": {"year": 3, "month": 1},
      "weight": "3",
      "price": 0,
      "adoptedBy": null,
      "adoptedAt": null,
      "createdAt": "2022-07-01T08:29:40.267Z",
      "updatedAt": "2022-07-01T08:29:40.267Z",
      "__v": 0,
      "userObjectId": "62b9a44873ea3188eafe2f92",
      "postIdString": "62beb0743ea8b2f874d10583",
      "user": {
        "_id": "62b9a44873ea3188eafe2f92",
        "email": "shinobu@mail.com",
        "firstName": "shinobuuu",
        "lastName": "oshino",
        "address": {
          "addressId": "cd26ead6-d17d-4c2e-b0af-09021128a3f2",
          "district": "BangRak",
          "province": "Bangkok",
          "country": "Thailand",
          "_id": "62b9a5d673ea3188eafe2fb0"
        },
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/integrated-ii.appspot.com/o/files%2Fimages.jpeg2022-06-27%2019%3A43%3A00.299787?alt=media&token=d25d0a12-a828-4e43-8e02-df41ee5cc541",
        "createdAt": "2022-06-27T12:27:41.868Z",
        "__v": 0
      },
      "adoptedByUserId": null,
    },
    {
      "_id": "62b9a94173ea3188eafe300d",
      "userId": "62b987f9dc03f8836b34cd05",
      "petName": "Stray cats around my village",
      "images": [
        "https://firebasestorage.googleapis.com/v0/b/integrated-ii.appspot.com/o/files%2Fimages%20(1).jpeg2022-06-27%2019%3A57%3A33.054322?alt=media&token=1b165789-93de-4d88-ac1d-2ed37a2d0e91"
      ],
      "address": {
        "addressId": "cd26ead6-d17d-4c2e-b0af-09021128a3f2",
        "district": "Saimai",
        "province": "Bangkok",
        "country": "Thailand",
        "_id": "62b9a94173ea3188eafe300e"
      },
      "description":
          "I saw too many stray cats around the villages. i have to ask to guard about them already. it not have owner. i think they should take proper care.\n",
      "sex": "unknown",
      "age": null,
      "weight": null,
      "price": 0,
      "adoptedBy": null,
      "adoptedAt": null,
      "createdAt": "2022-06-27T12:57:37.041Z",
      "updatedAt": "2022-06-27T12:57:37.041Z",
      "__v": 0,
      "userObjectId": "62b987f9dc03f8836b34cd05",
      "postIdString": "62b9a94173ea3188eafe300d",
      "user": {
        "_id": "62b987f9dc03f8836b34cd05",
        "email": "kan@mail.com",
        "firstName": "Nonthakorn",
        "lastName": "Inthong",
        "address": {
          "addressId": "0e229b29-9738-438b-8c97-2f00933409f1",
          "district": "Saimai",
          "province": "Bangkok",
          "country": "Thailand",
          "_id": "62b99caff4a87210c12af15c"
        },
        "imageUrl":
            "https://firebasestorage.googleapis.com/v0/b/integrated-ii.appspot.com/o/files%2Fimages.jpeg2022-06-27%2017%3A35%3A55.182093?alt=media&token=168bb2d2-65a4-4878-b311-ce8695960c30",
        "createdAt": "2022-06-27T06:47:00.874Z",
        "__v": 0
      },
      "adoptedByUserId": null,
      "chat": {}
    },
  ];

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: AppTheme.colors.primary,
        backgroundColor: Colors.white,
        onRefresh: () async {
          // print('refresh');
          await _refreshChatList();
          return Future.delayed(const Duration(seconds: 1));
        },
        child: AuthenWrapper());
  }

  Widget ChatListWidget() {
    return FutureBuilder(
        future: ChatServices.getChatList(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return EmptyPostsTypeError(error: snapshot.error.toString());
          }
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              List temp = snapshot.data as List;
              List chat_rooms = temp.toList();

              if (chat_rooms == null || chat_rooms.length == 0) {
                return SafeArea(
                  child: Container(
                    margin: EdgeInsets.only(left: 10, right: 10),
                    child: emptyChatRooms(
                        text:
                            "No chat rooms here. Try to contact some post to adopt."),
                  ),
                );
              }

              return Container(
                  child: ListView.builder(
                      itemCount: chat_rooms.length,
                      itemBuilder: (context, i) {
                        return ListTile(
                          tileColor:
                              chat_rooms[i]?['adoptStatus'] == "CONFIRMED"
                                  ? Colors.green[50]
                                  : Colors.transparent,
                          title: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.only(bottom: 4),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 4),
                                      child: Text(
                                        chat_rooms[i]?['post']?['petName'],
                                        style: AppTheme.style.primaryFontStyle,
                                      ),
                                    ),
                                    Text(
                                      ExtensionServices
                                          .convertTimestampToTimeago(
                                              chat_rooms[i]?['updatedAt']),
                                      style: AppTheme.style.secondaryFontStyle,
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(right: 2),
                                      child: CircleAvatar(
                                        child: _computedAvatar(chat_rooms[i]
                                            ?['toUser']?['imageUrl']),
                                        backgroundColor: Colors.white,
                                        radius: 12,
                                      ),
                                    ),
                                    Text(
                                      chat_rooms[i]?['toUser']?['firstName'],
                                      style: AppTheme.style.secondaryFontStyle
                                          .copyWith(
                                              fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                          leading: Stack(children: [
                            ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.network(
                                  _computedImage(chat_rooms[i]),
                                  width: 70,
                                  height: 70,
                                )),
                            confirmCheckWidget(chat_rooms[i]?['adoptStatus'])
                          ]),
                          trailing: Container(
                            width: 35,
                            child: ElevatedButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return ChatScreen(
                                      chatId: chat_rooms[i]?['_id'],
                                      post: chat_rooms[i]?['post'],
                                      user: chat_rooms[i]?['user'],
                                      toUser: chat_rooms[i]?['toUser'],
                                    );
                                  }));
                                },
                                child: Icon(
                                  Icons.chat,
                                  size: 18,
                                ),
                                style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.all(0),
                                    elevation: 0,
                                    shape: CircleBorder())),
                          ),
                        );
                      }));
            }
          }

          return LoadingWidget();
        });
  }

  confirmCheckWidget(adoptStatus) {
    if (adoptStatus != null) {
      // print(adoptStatus);
      if (adoptStatus.toString() == 'CONFIRMED') {
        return Positioned(
          top: 0,
          right: 0,
          child: CircleAvatar(
            radius: 10,
            child: const Icon(
              Icons.check,
              size: 12,
              color: Colors.white,
            ),
            backgroundColor: Colors.green[200],
          ),
        );
      }
      // return Text(adoptStatus.toString());
    }

    return Container(
      child: const Text(' '),
    );
  }

  Widget AuthenWrapper() {
    if (!_loading) {
      // print('is not loading');
      if (_user?['_id'] != null) {
        return ChatListWidget();
      }
      return Center(
        child: Container(
          child: const Text('Please login to start conversation.'),
        ),
      );
    }
    // print('is loading');
    return const LoadingWidget();
  }

  _computedImage(var chat_room) {
    if (chat_room?['post']?['images']?[0] == null) {
      return AppTheme.src.empty;
    }
    return chat_room['post']?['images']?[0];
  }

  _computedAvatar(String? profileImage) {
    if (profileImage != null) {
      return Image.network(profileImage);
    }
    return Icon(
      Icons.person,
      size: 16,
      color: AppTheme.colors.darkFontColor,
    );
  }
}
