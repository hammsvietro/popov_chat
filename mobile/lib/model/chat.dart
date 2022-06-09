import 'package:flutter/cupertino.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/model/user.dart';

class Chat {
  List<Message> _messages = [];
  List<User> users;
  String name;
  Image image;
  int id;

  Chat({
    required this.name,
    required this.image,
    required this.id,
    required this.users,
    required List<Message> messages,
  }) {
    _messages = messages;
  }

  get messages {
    _messages.sort((a,b) => a.insertedAt.compareTo(b.insertedAt));
    return _messages;
  }

  get lastMessageSent {
    return _messages.isEmpty ? null : _messages.first;
  }

  static Chat fromMap(Map<String, dynamic> map) {
    return Chat(
      name: map["name"],
      image: Image.network(map["image"], width: 40),
      id: map["id"],
      users: (map["users"] as List<dynamic>)
          .map((e) => User.fromPayload((e))).toList(),
      messages: 
        (map["messages"]  as List<dynamic>)
          .map((e) => Message.fromPayload(e)).toList()
    );
  }

  static List<Chat> manyFromMap(List<Map<String, dynamic>> mapList) {
    return mapList.map((e) => Chat.fromMap(e)).toList();
  }
}
