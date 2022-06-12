import 'package:flutter/material.dart';

class DetailChatAppBar extends StatefulWidget {
  const DetailChatAppBar({Key? key}) : super(key: key);

  @override
  State<DetailChatAppBar> createState() => _DetailChatAppBarState();
}

class _DetailChatAppBarState extends State<DetailChatAppBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton(
              onPressed: () {},
              child: Text(
                'Back',
                style: TextStyle(
                    fontSize: 16, color: Colors.white.withOpacity(0.5)),
              )),
        ],
      ),
    );
  }
}
