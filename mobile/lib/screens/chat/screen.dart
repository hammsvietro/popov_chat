import 'package:flutter/material.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/state.dart';
import 'package:popov_chat/theme.dart';

class ChatWidget extends StatefulWidget {
  final groupId;
  const ChatWidget({Key? key, required this.groupId}) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late Chat chat;
  @override
  void initState() {
    super.initState();
    chat = AppState().getChat(widget.groupId);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Nome do grupo"),
          backgroundColor: ChatTheme.backgroundColor,
          foregroundColor: Colors.white,
        ),
        body: Center(

        ));
    
  }
}
