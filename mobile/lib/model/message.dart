import 'package:flutter/cupertino.dart';
import 'package:popov_chat/model/user.dart';

class Message {
  int id;
  String content;
  DateTime insertedAt;
  Image? image;
  User sender; 
  int groupId;

  Message({
    required this.sender,
    required this.insertedAt,
    required this.groupId,
    required this.id,
    required this.content,
    this.image,
  });


  static Message fromPayload(Map<dynamic, dynamic> payload) {
    return Message(
      id: payload["id"],
      content: payload["content"],
      insertedAt: DateTime.parse(payload["inserted_at"]),
      sender: User.fromPayload(payload["user"]),
      groupId: payload["group_id"],
    );
  }

  @override
  bool operator == (other) => 
     other is Message && id == other.id;

  @override
  int get hashCode => hashValues(id, groupId, insertedAt.hashCode);

}

class MessagePushPayload {
  String content;
  int groupId;
  MessagePushPayload({required this.content, required this.groupId});

  Map<String, dynamic> toPayload() {
    return {
      "content": content,
      "groupId": groupId,
    };
  }
}
