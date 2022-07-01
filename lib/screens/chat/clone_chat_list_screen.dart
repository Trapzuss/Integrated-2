import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:pet_integrated/screens/chat/clone_chat_screen.dart';
import 'package:uuid/uuid.dart';

class CloneChatListScreen extends StatefulWidget {
  const CloneChatListScreen({Key? key}) : super(key: key);

  @override
  State<CloneChatListScreen> createState() => _CloneChatListScreenState();
}

class _CloneChatListScreenState extends State<CloneChatListScreen> {
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
        "_id": Uuid().v4(),
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
    return Column(
      children: [
        GestureDetector(
          key: Key("1"),
          child: Container(
            child: const Card(
              child: Text('room1'),
            ),
          ),
          onTap: () {
            // log("tap to 001");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CloneChatScreen(
                  post: postsTemp[0],
                  user: postsTemp[0]?['user'],
                  chatId: "001");
            }));
          },
        ),
        GestureDetector(
          key: Key("2"),
          child: Container(
            child: const Card(
              child: Text('room2'),
            ),
          ),
          onTap: () {
            // log("tap to 002");
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return CloneChatScreen(
                  post: postsTemp[1],
                  user: postsTemp[1]?['user'],
                  chatId: "002");
            }));
          },
        )
      ],
    );
  }
}
