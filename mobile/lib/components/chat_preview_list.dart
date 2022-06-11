import 'dart:async';

import 'package:flutter/material.dart';
import 'package:popov_chat/api.dart';
import 'package:popov_chat/components/chat_preview.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/routes.dart';
import 'package:popov_chat/screens/chat/screen.dart';
import 'package:popov_chat/state.dart';

enum ChatPreviewMode {
  joined,
  notJoined
}

class ChatPreviewList extends StatefulWidget {
  final ChatPreviewMode mode;
  const ChatPreviewList({Key? key, required this.mode}) : super(key: key);
   
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
    _chats = widget.mode == ChatPreviewMode.joined
        ? AppState().chats
        : await ApiClient().listNotJoinedGroups();
    setState(() {
      _hasLoaded = true;
    });
  }

  Future<void> _onTap(int groupId) async {
    if(widget.mode == ChatPreviewMode.notJoined) {
      await ApiClient().joinGroup(groupId);
      await AppState().reloadChats();
      _removeCurrentPageFromstack();
    }
    _goToChatPage(groupId);
  }

  _goToChatPage(int groupId) {
    Navigator.pushNamed(
        context,
        '/chat',
        arguments: ChatWidgetArguments(groupId: groupId));
  }

  _removeCurrentPageFromstack() {
    Navigator.removeRoute(context, materialRoutes['/find-groups']!);
  }

  List<Widget> _renderChatPreviews() {
    return _chats.map(
      (Chat chatPreview) => ChatPreviewComponent(
        chatPreview: chatPreview,
        onTap: _onTap,
        showMessage: widget.mode == ChatPreviewMode.joined
      )
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    if(!_hasLoaded) {
      return Column();
    }
    return ListView(
      shrinkWrap: true,
      children: _renderChatPreviews()
    );
  }
}

