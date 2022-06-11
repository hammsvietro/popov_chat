import 'package:flutter/material.dart';
import 'package:popov_chat/components/chat_preview_list.dart';
import 'package:popov_chat/theme.dart';

class FindGroups extends StatelessWidget {
  const FindGroups({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Find a group"),
        backgroundColor: ChatTheme.backgroundColor,
        foregroundColor: Colors.white,
      ),
      body: const ChatPreviewList(mode: ChatPreviewMode.notJoined)
    );
  }
}
