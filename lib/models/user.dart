import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserModel {
  String id;
  String email;
  String firstName;
  String lastName;
  String iconUrl;
  Color bgColor;

  UserModel(this.id, this.email, this.firstName, this.lastName, this.iconUrl,
      this.bgColor);

  static List<UserModel> generateUsers() {
    return [
      UserModel("0", '', 'Cecily', 'Trurr', '', Color(0xFFFDBEC8)),
      UserModel("1", '', 'Abs', 'Rwas', '', Color(0xFFFDBEC8))
    ];
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'email': email,
        'firstName': firstName,
        'lastName': lastName,
        'iconUrl': iconUrl,
        'bgColor': bgColor.value,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        json['id'],
        json['email'],
        json['firstName'],
        json['lastName'],
        json['iconUrl'],
        Color(json['bgColor']),
      );
}

class UserData {
  String id;
  String email;
  String firstName;
  String lastName;
  String iconUrl;
  Color bgColor;

  UserData(this.id, this.email, this.firstName, this.lastName, this.iconUrl,
      this.bgColor);
}
