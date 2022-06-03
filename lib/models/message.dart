import 'package:pet_integrated/models/user.dart';

class MessageModel {
  UserModel user;
  String lastMessage;
  String lastTime;
  bool isContinue;
  MessageModel(this.user, this.lastMessage, this.lastTime,
      {this.isContinue = false});

  static List<MessageModel> generateMessages() {
    return [
      MessageModel(users[0], 'Hey', '18:32'),
      MessageModel(users[1], 'Ye', '20.11'),
      MessageModel(users[0], 'Yo', '20.12'),
    ];
  }

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'lastMessage': lastMessage,
        'lastTime': lastTime,
        'isContinue': isContinue,
      };

  factory MessageModel.fromJson(Map<String, dynamic> json) => MessageModel(
        UserModel.fromJson(json['user']),
        json['lastMessage'],
        json['lastTime'],
        isContinue: json['isContinue'],
      );
}

var users = UserModel.generateUsers();
