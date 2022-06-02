import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popov_chat/model/chat.dart';

class ChatPreviewComponent extends StatefulWidget {
  final ChatPreview chatPreview;
  const ChatPreviewComponent({Key? key, required this.chatPreview}) : super(key: key);
   
  @override
  State<ChatPreviewComponent> createState() => _ChatPreviewState();
} 

class _ChatPreviewState extends State<ChatPreviewComponent> {

  @override
  void initState() {
    super.initState();
  }

  final DateFormat formatter = DateFormat('jm');
  
  get formattedDate {
    return formatter.format(widget.chatPreview.lastMessage!.dateSent);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(width: 0.0, color: Color(0xFFFFFFFF)),
          left: BorderSide(width: 0.0, color: Color(0xFFFFFFFF)),
          right: BorderSide(width: 0.0, color: Color(0xFFFFFFFF)),
          bottom: BorderSide(width: 0.0, color: Color(0xFFFFFFFF)),
        )
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16,left: 12,right: 12,bottom: 16),
        child: Row(
          children: [
            widget.chatPreview.image,
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(widget.chatPreview.name),
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Text(
                    "${widget.chatPreview.lastMessage?.sender.name}: ${widget.chatPreview.lastMessage?.content}",
                    overflow: TextOverflow.ellipsis,
                  )
,)              ]
            ),
            const Spacer(),
            Text(formattedDate)
          ]
        ),
      )
    );
  }
}

