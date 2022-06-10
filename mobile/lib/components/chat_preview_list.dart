import 'dart:async';

import 'package:flutter/material.dart';
import 'package:popov_chat/components/chat_preview.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/state.dart';

class ChatPreviewList extends StatefulWidget {
  const ChatPreviewList({Key? key}) : super(key: key);
   
  @override
  State<ChatPreviewList> createState() => _ChatPreviewListState();
} 

class _ChatPreviewListState extends State<ChatPreviewList> {

  late List<Chat> _chats;
  bool _hasLoaded = false;
  StreamSubscription? _stateChangedSub;

  @override
  void initState() {
    super.initState();
    getChats();
    _stateChangedSub = AppState().getStateChangedStream().listen((_) => setState(() => {}) );
  }

  @override
  void dispose() {
    _stateChangedSub?.cancel();
    super.dispose();
  }


  Future<void> getChats() async {
    _chats = AppState().chats;
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

