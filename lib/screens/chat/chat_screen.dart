import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_appbar.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_contact_info.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_messages.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import 'package:uuid/uuid.dart';
import 'package:username_gen/username_gen.dart';
import '../../models/message.dart';
import '../../models/user.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final _messageController = TextEditingController();
  List<MessageModel> messages = [];

  @override
  void initState() {
    connectSocket();
    super.initState();
  }

  @override
  void dispose() {
    socket
        .disconnect(); // --> disconnects the Socket.IO client once the screen is disposed
    super.dispose();
  }

  void connectSocket() {
    var url =
        Platform.isAndroid ? 'http://10.0.2.2:4000' : 'http://localhost:4000';
    socket = IO.io(
        'http://10.0.2.2:4000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .disableAutoConnect() // disable auto-connection
            .build());
    socket.connect();
    socket.onConnect((data) {
      print('Connected to socket.io server');
      socket.emit('join', 'join from client');
      socketListener();
      // socket.emit('sign-in', myId);
    });
    socket.onDisconnect((data) {
      print('disconnected');
    });

    socket.on('fromServer', (data) => print(data));
  }

  socketListener() {
    socket.on('received-messages', (data) {
      setState(() {
        messages = data
            .map<MessageModel>((json) => MessageModel.fromJson(json))
            .toList();
      });
      print('update');
      // print(messages);
    });
  }

  void _sendMessage() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('Hms').format(now);
    UserModel user = UserModel(
        Uuid().v1(),
        '',
        UsernameGen.generateWith(
          data: UsernameGenData(
            names: ['Curry', 'Thai', 'Land'],
            adjectives: ['Yo', 'Sup', 'Hi'],
          ),
        ),
        'Lastname',
        '',
        Color(0xFFFDBEC8));
    var messageJson = {
      "user": user.toJson(),
      "lastMessage": _messageController.text,
      "lastTime": formattedDate,
      "isContinue": false,
    };

    socket.emit('createMessage', messageJson);
    _messageController.clear();
    socketListener();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.primary,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 110,
        flexibleSpace: SafeArea(
          child: Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [DetailChatAppBar(), DetailContactInfo()],
          )),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
                child: socket.connected
                    ? DetailMessages(
                        // refresh: _fetchMessage,
                        messages: messages,
                        sendMessage: _sendMessage,
                        messageController: _messageController,
                      )
                    : Container(
                        child: Center(
                          child: Text('Connecting...'),
                        ),
                      )),
          ],
        ),
      ),
    );
  }
}
