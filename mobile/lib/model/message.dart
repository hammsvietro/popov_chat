import 'package:flutter/cupertino.dart';
import 'package:popov_chat/model/user.dart';

class Message {
  String? content;
  DateTime dateSent;
  Image? image;
  User sender; 

  Message({required this.sender, required this.dateSent, this.content, this.image});
}
