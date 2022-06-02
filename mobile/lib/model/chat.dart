import 'package:flutter/cupertino.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/model/user.dart';

class ChatBase {
  String name;
  Image image;

  ChatBase({required this.name, required this.image});
}

class ChatPreview extends ChatBase {
  Message? lastMessage;

  ChatPreview({
    required String name,
    required Image image,
    this.lastMessage
  }) : super(name: name, image: image);
}

class Chat extends ChatBase {
  List<Message> messages;
  List<User> users;
  Chat({
    required String name,
    required Image image,
    required this.messages,
    required this.users
  }) : super(name: name, image: image);
}
