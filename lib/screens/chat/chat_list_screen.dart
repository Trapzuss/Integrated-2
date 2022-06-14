import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/screens/chat/chat_screen.dart';
import 'package:pet_integrated/utils/theme.dart';

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({Key? key}) : super(key: key);

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  @override
  Widget build(BuildContext context) {
    List users = [
      {
        'name': 'Zeeza',
        'updatedAt': '2 hours ago',
        'lastMessage': 'I think you should come and get it by yourself.',
        'imageUrl':
            'https://i.pinimg.com/564x/a6/a5/9c/a6a59cf39b63d214cb7feab97b8c9a59.jpg'
      },
      {
        'name': 'Homons',
        'updatedAt': '2 mins ago',
        'lastMessage': 'Yeah, i agree!',
        'imageUrl':
            'https://i.pinimg.com/564x/fc/78/74/fc7874948bc5b1dca9eaeee61b93cfdb.jpg'
      },
    ];

    return Container(
        child: ListView.builder(
            itemCount: users.length,
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
                              users[i]['name'],
                              style: AppTheme.style.primaryFontStyle,
                            ),
                          ),
                          Text(
                            users[i]['updatedAt'],
                            style: AppTheme.style.secondaryFontStyle,
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        Flexible(
                            child: Text(
                          '${users[i]['lastMessage']}',
                          style: AppTheme.style.secondaryFontStyle,
                          overflow: TextOverflow.ellipsis,
                        ))
                      ],
                    )
                  ],
                ),
                leading: CircleAvatar(
                    backgroundImage: NetworkImage(users[i]['imageUrl'])),
                trailing: Container(
                  width: 35,
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ChatScreen();
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
