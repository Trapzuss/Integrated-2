import 'package:flutter/material.dart';
import 'package:pet_integrated/utils/theme.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_appbar.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_contact_info.dart';
import 'package:pet_integrated/widgets/chat/detail_chat_messages.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late IO.Socket socket;
  final _messageController = TextEditingController();
  @override
  void initState() {
    super.initState();
    connect();
  }

  void connect() {
    // http://localhost:3000
    // http://10.0.2.2:3000
    // http://192.168.0.193:3000
    // Dart client
    IO.Socket socket = IO.io('http://10.0.2.2:3000', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
    print(socket.connected);
    socket.on('findAllMessages', (data) => print(data));
    socket.onDisconnect((_) => print('disconnect'));
    socket.on('fromServer', (_) => print(_));
  }

  void _sendMessage() {
    print(_messageController.text);
    socket.emit('createMessage', _messageController.text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.colors.primary,
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 110,
        flexibleSpace: Container(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [DetailChatAppBar(), DetailContactInfo()],
        )),
      ),
      body: Column(
        children: [
          Expanded(
              child: DetailMessages(
            sendMessage: _sendMessage,
            messageController: _messageController,
          ))
        ],
      ),
    );
  }
}
