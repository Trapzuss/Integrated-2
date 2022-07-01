import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_integrated/common/empty_widget.dart';
import 'package:pet_integrated/layouts/default_layout.dart';
import 'package:pet_integrated/screens/posts/post_screen.dart';
import 'package:pet_integrated/services/posts.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/utils/utils.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_appbar.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_contact_info.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';
import 'package:username_gen/username_gen.dart';

class CloneChatScreen extends StatefulWidget {
  var chatId;
  var post;
  var user;

  CloneChatScreen({
    Key? key,
    required this.post,
    required this.user,
    required this.chatId,
  }) : super(key: key);

  @override
  State<CloneChatScreen> createState() => _CloneChatScreenState();
}

class _CloneChatScreenState extends State<CloneChatScreen> {
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

    setState(() {});
  }

  Future<void> _connectSocket() async {
    String chatId = widget.chatId;
    log(chatId);
    socket = IO.io(
        'http://10.0.2.2:4000',
        IO.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .build());
    socket.connect();
    socket.onConnect((data) {
      log("connect");
      socket.emit('chatId', {
        "chatId": chatId,
        "byUserId": widget.user['_id'],
        "postId": widget.post['_id'],
      });
      socket.on("received-messages", (data) {
        if (data != null) {
          log(data);
        }
      });
    });
    socket.onDisconnect((data) {
      log('disconnected');
    });
  }

  _socketListener() async {
    socket.on('received-messages', (data) {
      if (data != null) {
        log(data);
      }
    });
  }

  _sendMessage(String? messageType) async {
    var messageJson = {
      "postId": widget.post['_id'],
      "chatId": widget.chatId,
      "byUserId": widget.user['_id'],
      "messageText": _messageController.text,
      "messageType": "DEFAULT_MESSAGE"
    };

    if (_messageController.text != null) {
      socket.emit('createMessage', messageJson);
      _messageController.clear();
    }
    // _socketListener();
  }

  @override
  void initState() {
    // log("INIT");
    _connectSocket();
    super.initState();
  }

  @override
  void dispose() {
    _messageController.dispose();
    socket.disconnect();
    socket.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.primary,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        elevation: 0,
        toolbarHeight: 110,
        flexibleSpace: SafeArea(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [BackButton(), Text('headers ${widget.chatId}')],
          )),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: TextField(
              controller: _messageController,
            )),
            IconButton(
                onPressed: () {
                  _sendMessage("DEFAULT_MESSAGE");
                },
                icon: const Icon(Icons.send))
          ],
        ),
      ),
    );
  }
}
