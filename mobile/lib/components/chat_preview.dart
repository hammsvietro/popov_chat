import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popov_chat/model/chat.dart';

class ChatPreviewComponent extends StatefulWidget {
  final Chat chatPreview;
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
    if(widget.chatPreview.lastMessageSent == null) return "";
    return formatter.format(widget.chatPreview.lastMessageSent!.insertedAt);
  }


  get message {
    if(widget.chatPreview.lastMessageSent != null) {
      return Text(
        "${widget.chatPreview.lastMessageSent?.sender.name}: ${widget.chatPreview.lastMessageSent?.content}",
        overflow: TextOverflow.ellipsis,
      );
    } else {
      return const Text("No messages sent yet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => {print("tapped")},
      child: Container(
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
          padding: const EdgeInsets.only(top: 26,left: 12,right: 12,bottom: 26),
          child: Row(
            children: [
              widget.chatPreview.image,
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(widget.chatPreview.name),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 250),
                      child: message
                    )
                  ]
                )
              ),
              const Spacer(),
              Text(formattedDate)
            ]
          ),
        )
      )
    );
  }
}

