import 'package:flutter/cupertino.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/model/user.dart';

class ChatBase {
  String name;
  Image image;
  int id;

  ChatBase({required this.name, required this.image, required this.id});
}

class ChatPreview extends ChatBase {
  Message? lastMessage;

  ChatPreview({
    required String name,
    required Image image,
    required int id,
    this.lastMessage
  }) : super(name: name, image: image, id: id);
}

class Chat extends ChatBase {
  List<Message> _messages = [];
  List<User> users;
  Chat({
    required String name,
    required Image image,
    required int id,
    required this.users,
    required List<Message> messages,
  }) : super(name: name, image: image, id: id) {
    _messages = messages;
  }

  get messages {
    _messages.sort((a,b) => a.insertedAt.compareTo(b.insertedAt));
    return _messages;
  }
}
