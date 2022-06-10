import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/theme.dart';

class MessageListWidget extends StatefulWidget {
  final Chat chat;
  final int userId;
  const MessageListWidget({Key? key, required this.chat, required this.userId}) : super(key: key);

  @override
  State<MessageListWidget> createState() => _MessageListWidgetState();
}

class _MessageListWidgetState extends State<MessageListWidget> {
  String? input;
  final DateFormat formatter = DateFormat('jm');

  Widget _messageBox(Message message, bool isSelf) {
    return Column(
      children: [
        (isSelf
          ? const SizedBox.shrink()
          : Text(message.sender.name)),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(message.content, style: TextStyle(color: isSelf ? Colors.black : Colors.white)),
            Text(formatter.format(message.insertedAt))
          ]
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(bottom: 12),
      child: ListView.builder(
        itemCount: widget.chat.messages.length,
        reverse: true,
        itemBuilder: (context, index) {
          Message message = widget.chat.messages[index];
          bool isSelf = message.sender.id == widget.userId;
          return Container(
            padding: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            margin: const EdgeInsets.only(left: 8, right: 8, bottom: 4, top: 4),
            child: Row(
              key: Key(message.id.toString()),
              mainAxisAlignment: isSelf
                ? MainAxisAlignment.end
                : MainAxisAlignment.start,
                children: [
                Row(children: [
                ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxWidth: 240,
                    minWidth: 50,
                    maxHeight: 1000,
                    minHeight: 40
                  ),
                    child: 
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(Radius.circular(8)),
                        color: isSelf ? ChatTheme.primaryColor : ChatTheme.surfaceColor
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          (isSelf
                            ? const SizedBox.shrink()
                            : Container(
                              margin: const EdgeInsets.only(bottom: 8),
                              child: Text(message.sender.name, style: const TextStyle(fontWeight: FontWeight.bold))
                              )),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Flexible(child: Text(message.content, style: TextStyle(color: isSelf ? Colors.black : Colors.white)),),
                              Text(formatter.format(message.insertedAt), style: TextStyle(color: isSelf ? Colors.black : Colors.white))
                            ]
                          )
                        ],
                      )
                    ),
                  )
                ]),
              ],
            ), 
          );
      }),
    );
  }
}
