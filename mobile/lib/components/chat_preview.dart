import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/screens/chat/screen.dart';

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
      return SizedBox(
        width: 250,
        child: Text(
          "${widget.chatPreview.lastMessageSent?.sender.name}: ${widget.chatPreview.lastMessageSent?.content}",
          maxLines: 1,
          style: const TextStyle(fontSize: 13)
        )
      );
    } else {
      return const Text("No messages sent yet");
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.pushNamed(
        context,
        '/chat',
        arguments: ChatWidgetArguments(groupId: widget.chatPreview.id)
      ),
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
                Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.chatPreview.image)
                    )
                  ),
              ),
              Container(
                padding: const EdgeInsets.only(left: 8),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.chatPreview.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      )
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 2),
                      constraints: const BoxConstraints(maxWidth: 220),
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

