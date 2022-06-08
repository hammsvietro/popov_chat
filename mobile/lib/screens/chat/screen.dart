import 'package:flutter/material.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/screens/chat/input.dart';
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
  bool hasLoaded = false;
  @override
  void initState() {
    super.initState();
    chat = AppState().getChat(widget.groupId);
    hasLoaded = true;
    setState(() => {});
  }
  @override
  Widget build(BuildContext context) {
    if (!hasLoaded) {
      return const Scaffold();
    }
    return Scaffold(
      appBar: AppBar(title: Text(chat.name),
        backgroundColor: ChatTheme.backgroundColor,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          const Expanded(child: Text("hey")),
          ChatInputWidget(onSubmit: (input) => print(input))
        ],
      )
    );
    
  }
}
