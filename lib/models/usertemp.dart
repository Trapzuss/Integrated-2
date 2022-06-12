import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserTempModel {
  String _id;
  String email;
  String username;
  String userDisplayName;

  UserTempModel(this._id, this.email, this.username, this.userDisplayName);

  Map<String, dynamic> toJson() => {
        '_id': _id,
        'email': email,
        'username': username,
        'userDisplayName': userDisplayName,
      };

  factory UserTempModel.fromJson(Map<String, dynamic> json) => UserTempModel(
        json['_id'],
        json['email'],
        json['username'],
        json['userDisplayName'],
      );
}
