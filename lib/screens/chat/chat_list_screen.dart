import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/screens/chat/chat_screen.dart';
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
  Widget build(BuildContext context) {
    return RefreshIndicator(
        color: AppTheme.colors.primary,
        backgroundColor: Colors.white,
        onRefresh: () async {
          // print('refresh');
          await _refreshChatList();
          return Future.delayed(Duration(seconds: 1));
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

              // print(chat_rooms);
              // print(chat_rooms[0]);
              // print(chat_rooms[0]?['participants']);
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
                          leading: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.network(
                                _computedImage(chat_rooms[i]),
                                width: 70,
                                height: 70,
                              )),
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

  Widget AuthenWrapper() {
    if (!_loading) {
      // print('is not loading');
      if (_user?['_id'] != null) {
        return ChatListWidget();
      }
      return Center(
        child: Container(
          child: Text('Please login to start conversation.'),
        ),
      );
    }
    // print('is loading');
    return LoadingWidget();
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
