import 'package:flutter/material.dart';
import 'package:pet_integrated/utils/theme.dart';

class DetailMessages extends StatefulWidget {
  DetailMessages(
      {Key? key, required this.messageController, required this.sendMessage})
      : super(key: key);
  var messageController = TextEditingController();
  Function sendMessage;
  @override
  State<DetailMessages> createState() => _DetailMessagesState();
}

class _DetailMessagesState extends State<DetailMessages> {
  final _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(children: [
        Container(
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
}
