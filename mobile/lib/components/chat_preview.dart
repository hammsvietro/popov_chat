import 'package:flutter/material.dart';

class ChatPreview extends StatefulWidget {
  const ChatPreview({Key? key}) : super(key: key);
  
  @override
  State<ChatPreview> createState() => _ChatPreviewState();
} 

class _ChatPreviewState extends State<ChatPreview> {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Text('sup'),
    );
  }
}

