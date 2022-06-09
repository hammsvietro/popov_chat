import 'package:flutter/material.dart';
import 'package:popov_chat/api.dart';
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

  late List<Chat> _chats;
  bool _hasLoaded = false;
  @override
  void initState() {
    super.initState();
    getChats();
  }

  Future<void> getChats() async {
    _chats = await ApiClient().listGroups();
    setState(() {
      _hasLoaded = true;
    });
  }

  List<Widget> _renderChatPreviews() {
    return _chats.map(
      (Chat chatPreview) => ChatPreviewComponent(chatPreview: chatPreview)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    if(!_hasLoaded) {
      return Column();
    }
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

