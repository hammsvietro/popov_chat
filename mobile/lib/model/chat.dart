import 'package:flutter/cupertino.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/model/user.dart';

class Chat {
  List<Message> _messages = [];
  List<User> users;
  String name;
  String image;
  int currentMessageChunk = 0;
  bool hasReadAllMessages = false;
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
    return _messages;
  }

  get lastMessageSent {
    return _messages.isEmpty ? null : _messages.first;
  }

  List<Message> addMessage(Message message) {
    _messages.insert(0, message);
    return _guaranteeUnique();
  }

  List<Message> addMessages(List<Message> messages) {
    _messages.insertAll(0, messages);
    return _guaranteeUnique();
  }

  List<Message> _guaranteeUnique() {
    _messages.sort((a, b) => b.insertedAt.compareTo(a.insertedAt));
    _messages = _messages.toSet().toList();
    return _messages;
  }

  static Chat fromMap(Map<String, dynamic> map) {
    return Chat(
      name: map["name"],
      image: map["image"],
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
