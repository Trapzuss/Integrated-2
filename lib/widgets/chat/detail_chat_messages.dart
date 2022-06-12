import 'package:flutter/material.dart';
import 'package:pet_integrated/models/message.dart';
import 'package:pet_integrated/utils/theme.dart';

class DetailMessages extends StatefulWidget {
  DetailMessages({
    Key? key,
    required this.messageController,
    required this.sendMessage,
    required this.messages,
    // required this.refresh
  }) : super(key: key);
  var messageController = TextEditingController();
  List<MessageModel> messages;
  Function sendMessage;
  // Function refresh;

  @override
  State<DetailMessages> createState() => _DetailMessagesState();
}

class _DetailMessagesState extends State<DetailMessages> {
  final _scrollController = ScrollController();
  final List<MessageModel> list = MessageModel.generateMessages();
  final String myId = "0";
  List<MessageModel> _message = [];

  _fetchMessage() {
    if (widget.messages.length != _message.length) {
      // setState(() {
      _message = widget.messages;
      // });
    }

    // print(widget.messages);
    print('fetch message in child');
    print(_message);
  }

  @override
  void initState() {
    super.initState();
    _fetchMessage();
  }

  @mustCallSuper
  @protected
  void didUpdateWidget(widget) {
    super.didUpdateWidget(widget);
    _fetchMessage();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                controller: widget.messageController,
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
                      widget.sendMessage();
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
    return ListView.separated(
        padding: EdgeInsets.zero,
        itemBuilder: ((context, index) => _message[index].user.id == myId
            ? _buildReceivedText(_message[index])
            : _buildSenderText(_message[index])),
        separatorBuilder: (_, index) => SizedBox(
              height: 1,
            ),
        itemCount: _message.length);
  }

  _buildReceivedText(message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          message.lastTime,
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
              child: Text(message.lastMessage),
            ))
      ],
    );
  }

  _buildSenderText(message) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Colors.grey[300], shape: BoxShape.circle),
              width: 40,
              child: Icon(Icons.person),
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
                  message.lastMessage,
                  style: TextStyle(
                      height: 1.5, color: AppTheme.colors.darkFontColor),
                ),
              ),
            ),
          ],
        ),
        Text(
          message.lastTime,
          style: TextStyle(color: AppTheme.colors.primary, fontSize: 12),
        ),
      ],
    );
  }
}
