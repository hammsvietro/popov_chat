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

  @override
  void initState() {
    super.initState();
  }

  List<ChatPreview> chats = [
  ChatPreview(
    id: 1,
    image: Image.asset("assets/images/prog_snob.png", width: 40),
      name: 'poprog',
      lastMessage: Message(
        id: 4,
        sender: User(id: 1, name: 'Popov', profilePicture: 'https://popovchat.s3.sa-east-1.amazonaws.com/images/a929d322-0eee-4e73-8eb0-1ff3b8fc0267stalin.webp'), insertedAt: DateTime.now(),
        groupId: 11,
        content: 'Ouçam haken'
      )
    ),
  ChatPreview(
    id: 2,
    image: Image.asset("assets/images/prog_snob.png", width: 40),
      name: 'futebol do popov',
      lastMessage: Message(
        id: 2, 
        sender: User(id: 1, name: 'Popov', profilePicture: 'https://popovchat.s3.sa-east-1.amazonaws.com/images/a929d322-0eee-4e73-8eb0-1ff3b8fc0267stalin.webp'), insertedAt: DateTime.now(),
        groupId: 12,
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

