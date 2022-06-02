import 'package:flutter/material.dart';
import 'package:popov_chat/components/chat_preview.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/model/user.dart';

class ChatPreviewList extends StatefulWidget {
  const ChatPreviewList({Key? key}) : super(key: key);
   
  @override
  State<ChatPreviewList> createState() => _ChatPreviewListState();
} 

class _ChatPreviewListState extends State<ChatPreviewList> {
  List<ChatPreview> chats = [
  ChatPreview(
    image: Image.asset("assets/images/prog_snob.png", width: 40),
      name: 'poprog',
      lastMessage: Message(
        sender: User(id: 1, name: 'Popov'), dateSent: DateTime.now(),
        content: 'Ouçam haken'
      )
    ),
  ChatPreview(
    image: Image.asset("assets/images/prog_snob.png", width: 40),
      name: 'futebol do popov',
      lastMessage: Message(
        sender: User(id: 1, name: 'Popov'), dateSent: DateTime.now(),
        content: 'fiz 4 embaixadinhas antes de ontem.'
      )
    ),
  ];
  
  List<Widget> _renderChatPreviews() {
    return chats.map(
      (ChatPreview chatPreview) => ChatPreviewComponent(chatPreview: chatPreview)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: _renderChatPreviews()
        ),
      ],
    );
  }
}

