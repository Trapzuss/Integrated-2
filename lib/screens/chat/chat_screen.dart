import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_appbar.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_contact_info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';
import 'package:username_gen/username_gen.dart';

class ChatScreen extends StatefulWidget {
  var chatId;
  var post;
  var user;
  var toUser;
  ChatScreen(
      {Key? key,
      required this.post,
      required this.user,
      required this.chatId,
      required this.toUser})
      : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  ScrollController _listScrollController = ScrollController();
  bool _isOwner = false;
  bool _loading = true;
  late IO.Socket socket;
  final _messageController = TextEditingController();
  var _chat;
  var _user;
  // var _toUser;
  List _messages = [];
  String _btnMessage = '';
  String? _adoptStatus;
  Future<void> _initialUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    dynamic user = prefs.get('user');
    Map<String, dynamic> userMap = {};
    if (user != null) {
      userMap = await jsonDecode(user) as Map<String, dynamic>;
    }
    _user = userMap;

    if (widget.user['_id'] == _user?['_id']) {
      _isOwner = true;
    }
    // print(widget.user['_id']);
    // print(_user?['_id']);
    // print(widget.user['_id'] == _user?['_id']);
    // print("_isOwner: ${_isOwner}");
    setState(() {});
  }

  // late Stream _streamMessages;

  // Stream _getStreamMessages() async* {
  //   socket.on('received-messages', (data) {
  //     print('stream!!!!!');
  //     if (data != null) {
  //       if (mounted) {
  //         // print('setState');
  //         setState(() {
  //           _toUser = data?['toUser'];
  //           _chat = data?['chat'];
  //           _messages = data?['chat']?['messages'];
  //         });
  //       }
  //     }
  //   });
  // }

  Future<void> _connectSocket() async {
    socket = IO.io(
        'http://10.0.2.2:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    socket.onConnect((data) {
      log('Connected to socket.io server');
      // socket.emit('join', 'join from client');
      socket
          .emit('chatId', {"chatId": widget.chatId, "byUserId": _user['_id']});
      socket.on('received-messages', (data) async {
        if (data != null) {
          if (mounted) {
            setState(() {
              // _toUser = data?['toUser'];
              _chat = data?['chat'];
              _messages = data?['chat']?['messages'];
              _adoptStatus = _chat?['adoptStatus'];
            });

            await _computedActionButton();

            if (_listScrollController.hasClients) {
              final position = _listScrollController.position.maxScrollExtent;
              _listScrollController.animateTo(
                position,
                duration: Duration(seconds: 1),
                curve: Curves.easeOut,
              );
            }
          }
        }
      });
    });
    socket.onDisconnect((data) {
      log('disconnected');
    });
    // print(_loading);
    if (mounted) {
      setState(() {
        _loading = false;
      });
    }
    // print(_messages);
    // print(_loading);
  }

  _socketListener() async {
    setState(() {
      _loading = true;
    });
    socket.on('received-messages', (data) {
      if (data != null) {
        if (mounted) {
          // print('set message');
          setState(() {
            _chat = data?['chat'];
            _messages = data?['chat']?['messages'];
            // _toUser = data?['toUser'];
          });
        }
      }
    });
    setState(() {
      _loading = false;
    });
  }

  _sendMessage(String? messageType) async {
    // print(messageType);
    String? chatId;
    String toUserId;
    String? text;

    if (widget.chatId == null) {
      if (_chat?['_id'] == null) {
        chatId = null;
      } else {
        chatId = _chat?['_id'];
      }
    } else {
      chatId = widget.chatId;
    }

    if (_user['_id'] == widget.post?['userId']) {
      toUserId = widget.toUser?['_id'];
    } else {
      toUserId = widget.post['userId'];
    }
    text = messageType != 'DEFAULT_MESSAGE'
        ? messageType
        : _messageController.text;
    var messageJson = {
      "postId": widget.post['_id'],
      "chatId": chatId,
      "byUserId": _user['_id'],
      "toUserId": toUserId,
      "messageText": text,
      "messageType": messageType ?? 'DEFAULT_MESSAGE'
    };
    // print(text);
    if (text != null) {
      // print('-----------SEND------------');
      socket.emit('createMessage', messageJson);
      _messageController.clear();
    }

    _socketListener();
    setState(() {});
  }

  _submitAdoptButton({String? option}) async {
    var computedButtonMessagesOwner = {
      "Idle": "DEFAULT_MESSAGE",
      "Cancel confirm": "CANCEL_CONFIRM",
      "Confirm adopt": "CONFIRM_ADOPT",
      "Reject adopt": "REJECT_ADOPT",
    };

    var computedButtonMessagesGuest = {
      "Request adopt": "REQUEST_ADOPT",
      "Cancel confirm": "CANCEL_CONFIRM",
      "Cancel request": "CANCEL_REQUEST_ADOPT",
    };
    var computedAdoptStatusState = {
      "Idle": "IDLE",
      "Cancel confirm": "IDLE",
      "Reject adopt": "IDLE",
      "Request adopt": "REQUESTED",
      "Cancel request": "IDLE",
      "Confirm adopt": "CONFIRMED",
      "IDLE": "IDLE",
      "REJECT_ADOPT": "IDLE",
      "REQUEST_ADOPT": "REQUESTED",
      "CONFIRM_ADOPT": "CONFIRMED",
      "CANCEL_CONFIRM": "IDLE",
      "CANCEL_REQUEST_ADOPT": "IDLE",
    };
    // log("submitAdoptButton1 ${_adoptStatus}");
    String? messageType;
    if (_isOwner) {
      messageType = computedButtonMessagesOwner[_btnMessage.toString()];
    } else {
      messageType = computedButtonMessagesGuest[_btnMessage.toString()];
    }
    if (option != null) {
      messageType = option;
    }
    // log("subAdopt-messageType ${messageType}");
    // log("submitAdoptButton2 ${_adoptStatus}");
    if (_btnMessage.toString() != "Idle") {
      await _sendMessage(messageType.toString());
      setState(() {
        _adoptStatus = computedAdoptStatusState[messageType.toString()];
      });
      // log("submitAdoptButton3 ${_adoptStatus}");
      await _computedActionButton();
    }
  }

  _computedActionButton() async {
    setState(() {
      _loading = true;
    });
    // print('computedActionBtn');
    // print(_loading);

    var computedButtonMessagesOwner = {
      "IDLE": "Idle",
      "CONFIRMED": "Cancel confirm",
      "REQUESTED": "Options",
    };
    var computedButtonMessagesGuest = {
      "IDLE": "Request adopt",
      "CONFIRMED": "Cancel confirm",
      "REQUESTED": "Cancel request",
    };
    // print(_chat != null);
    if (_chat != null) {
      if (_isOwner) {
        setState(() {
          _btnMessage = computedButtonMessagesOwner[_adoptStatus].toString();
        });
      } else {
        setState(() {
          _btnMessage = computedButtonMessagesGuest[_adoptStatus].toString();
        });
      }
    } else {
      if (_isOwner) {
        setState(() {
          _btnMessage = 'Idle';
        });
      } else {
        setState(() {
          _btnMessage = 'Request adopt';
        });
      }
    }

    // print(_adoptStatus);
    // print(_btnMessage);
    setState(() {
      _loading = false;
    });
    // print(_loading);
  }

  // @override
  // void didUpdateWidget(covariant ChatScreen oldWidget) {
  //   super.didUpdateWidget(oldWidget);
  //   if (mounted) {
  //     _socketListener();
  //     print('is has something');
  //   }
  // }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _loading = true;
        });
        // _getStreamMessages();

        _initialUserData().whenComplete(() async {
          _connectSocket();
          setState(() {
            _loading = false;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    if (mounted) {
      socket.disconnect();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        toolbarHeight: 110,
        flexibleSpace: SafeArea(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              DetailChatAppBar(),
              // Text("${widget.user['_id'] == _user?['_id']}"),
              DetailContactInfo(),

              // DetailContactInfo(
              //     chat: _chat,
              //     post: widget.post,
              //     user: widget.user,
              //     isOwner: widget.user['_id'] == _user?['_id'] ? true : false,
              //     sendMessage: _sendMessage)
            ],
          )),
        ),
      ),
      body: SafeArea(
        child: _loading
            ? loadingWidgetWithText(text: "Conecting . . .")
            : Column(
                children: [
                  Expanded(child: DetailMessages()),
                ],
              ),
      ),
    );
  }

  Widget DetailMessages() {
    return Container(
      child: Stack(children: [
        Container(
            child: ChatListView(),
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.fromLTRB(25, 50, 25, 80),
            decoration: BoxDecoration(
                color: AppTheme.colors.notWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)))),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            margin: EdgeInsets.only(bottom: 20),
            height: 50,
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Stack(children: [
              TextField(
                controller: _messageController,
                decoration: InputDecoration(
                    hintStyle: TextStyle(
                        color: AppTheme.colors.primary.withOpacity(0.4),
                        fontSize: 14),
                    hintText: "Type your message...",
                    fillColor: Colors.grey[300],
                    filled: true,
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(20))),
              ),
              Positioned(
                  right: 8,
                  bottom: 8,
                  child: InkWell(
                    onTap: () {
                      _sendMessage('DEFAULT_MESSAGE');
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: AppTheme.colors.primary,
                          shape: BoxShape.circle),
                      child: Icon(
                        Icons.send,
                        color: AppTheme.colors.secondaryFontColor,
                        size: 20,
                      ),
                    ),
                  )),
            ]),
          ),
        )
      ]),
    );
  }

  Widget ChatListView() {
    return _loading
        ? loadingWidgetWithText(text: "Loading messages . . .")
        :
        //  StreamBuilder(
        //     stream: _getStreamMessages(),
        //     builder: (context, snapshot) {
        //       return
        ListView.separated(
            controller: _listScrollController,
            padding: EdgeInsets.zero,
            itemBuilder: ((context, index) => _messages != null
                ? Container(
                    margin: EdgeInsets.only(bottom: 6),
                    child: _messages[index]?['userId'] == _user?['_id']
                        ? _buildSenderText(_messages[index])
                        : _buildReceivedText(_messages[index]))
                : Container()),
            separatorBuilder: (_, index) => SizedBox(
                  height: 1,
                ),
            itemCount: _messages != null ? _messages.length : 0);
    // });
  }

  _buildSenderText(message) {
    // print(message?['messageType'].toString().trim());

    return message?['messageType'].toString().trim() == "DEFAULT_MESSAGE"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                ExtensionServices.convertTimestampToDate(message['createdAt']),
                style: TextStyle(color: AppTheme.colors.primary, fontSize: 12),
              ),
              Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 180),
                    child: Text(message['messageText']),
                  ))
            ],
          )
        : _buildActionText(message);
  }

  _buildReceivedText(message) {
    // print(message?['messageType']);
    // print(_toUser);
    return message?['messageType'].toString().trim() == "DEFAULT_MESSAGE"
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                        color: Colors.grey[300], shape: BoxShape.circle),
                    width: 40,
                    child: widget.toUser?['imageUrl'] != null
                        ? CircleAvatar(
                            backgroundImage:
                                NetworkImage(widget.toUser?['imageUrl']),
                          )
                        : Icon(Icons.person),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.grey.withOpacity(0.1),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15),
                            topRight: Radius.circular(15),
                            bottomRight: Radius.circular(15))),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 180),
                      child: Text(
                        message['messageText'],
                        style: TextStyle(
                            height: 1.5, color: AppTheme.colors.darkFontColor),
                      ),
                    ),
                  ),
                ],
              ),
              Text(
                ExtensionServices.convertTimestampToDate(message['createdAt']),
                style: TextStyle(color: AppTheme.colors.primary, fontSize: 12),
              ),
            ],
          )
        : _buildActionText(message);
  }

  _buildActionText(message) {
    var computedMessagesMe = {
      'CANCEL_CONFIRM': 'You have cancel confirm adopt',
      'CONFIRM_ADOPT': 'You have confirm adopt',
      'REQUEST_ADOPT': 'You have request to adopt',
      'CANCEL_REQUEST_ADOPT': 'You have cancel the request',
      'REJECT_ADOPT': 'You have reject the adopt',
    };
    var computedMessagesTo = {
      'CANCEL_CONFIRM':
          "${widget.toUser?['firstName']} have cancel confirm adopt",
      'CONFIRM_ADOPT': "${widget.toUser?['firstName']} have confirm adopt",
      'REQUEST_ADOPT': "${widget.toUser?['firstName']} have request adopt",
      'CANCEL_REQUEST_ADOPT':
          "${widget.toUser?['firstName']} have cancel adopt",
      'REJECT_ADOPT': "${widget.toUser?['firstName']} have reject adopt",
    };
    String? messageComputed;
    String text = message['messageText'];

    // print(_isOwner);

    if (message?['messageType'] != "DEFALUT_MESSAGE") {
      if (message['userId'] == _user['_id']) {
        messageComputed = computedMessagesMe[text.toString().trim()];
      } else {
        messageComputed = computedMessagesTo[text.toString().trim()];
      }
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "${ExtensionServices.convertTimestampToTimeago(message['createdAt'])}  $messageComputed",
          style: TextStyle(color: AppTheme.colors.primary, fontSize: 12),
        ),
        Divider(
          color: AppTheme.colors.primary,
          height: 4,
        )
      ],
    );
  }

  // Appbar

  DetailContactInfo() {
    return !_loading
        ? Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: _getImageComputed(),
                ),
                Flexible(
                  child: Container(
                    margin: EdgeInsets.only(left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(bottom: 4),
                              child: Text("${widget.post['petName']}",
                                  style: AppTheme.style.titleFontStyle
                                      .copyWith(color: Colors.white)),
                            ),
                            _buttonComputed()
                          ],
                        ),
                        GestureDetector(
                          onTap: () async {
                            // print('set');
                            await _socketListener();
                            setState(() {});
                          },
                          child: Row(
                            children: [
                              _getAvatarComputed(),
                              Flexible(
                                child: Container(
                                  margin: EdgeInsets.only(left: 4),
                                  child: Text(
                                    widget.user?['firstName'] ==
                                            _user['firstName']
                                        ? "You"
                                        : widget.user?['firstName'],
                                    style: AppTheme.style.primaryFontStyle,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
              // children: [Text('${message.name}')],
            ),
          )
        : Container();
  }

  _buttonComputed() {
    if (_isOwner && _btnMessage == 'Options') {
      return _buildOptionButtonForOwner();
    }
    return Container(
      padding: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: AppTheme.colors.pink),
      child: GestureDetector(
          onTap: () {
            _submitAdoptButton();
          },
          child: Text(
            _btnMessage,
            style:
                AppTheme.style.primaryFontStyle.copyWith(color: Colors.white),
          )),
    );
  }

  _buildOptionButtonForOwner() {
    return Row(
      children: [
        Container(
          margin: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
          padding: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colors.pink),
          child: GestureDetector(
              onTap: () {
                _submitAdoptButton(option: "CONFIRM_ADOPT");
              },
              child: Text(
                'Confirm',
                style: AppTheme.style.primaryFontStyle
                    .copyWith(color: Colors.white),
              )),
        ),
        Container(
          padding: EdgeInsets.only(right: 8, left: 8, top: 4, bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: AppTheme.colors.pink),
          child: GestureDetector(
              onTap: () {
                _submitAdoptButton(option: "REJECT_ADOPT");
              },
              child: Text(
                'Reject',
                style: AppTheme.style.primaryFontStyle
                    .copyWith(color: Colors.white),
              )),
        ),
      ],
    );
  }

  _getImageComputed() {
    if (widget.post?['images']?[0] == null) {
      return Container(
        decoration: BoxDecoration(color: Colors.white),
        child: Image.asset(
          AppTheme.src.astroCat,
          width: 60,
          height: 60,
        ),
      );
    }
    return Image.network(
      widget.post?['images']?[0],
      width: 60,
      height: 60,
    );
  }

  _getAvatarComputed() {
    if (widget.toUser?['imageUrl'] != null) {
      return CircleAvatar(
        radius: 12,
        backgroundImage: NetworkImage("${widget.user?['imageUrl']}"),
        backgroundColor: Colors.white,
      );
    }
    return CircleAvatar(
      radius: 12,
      child: Icon(
        Icons.person,
        size: 16,
        color: AppTheme.colors.darkFontColor,
      ),
      backgroundColor: AppTheme.colors.notWhite,
    );
  }
}
