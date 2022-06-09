import 'package:flutter/material.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/model/user.dart';
import 'package:popov_chat/screens/chat/input.dart';
import 'package:popov_chat/screens/chat/message_list.dart';
import 'package:popov_chat/socket.dart';
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
  final SocketClient _socket = SocketClient();
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
        Expanded(child: MessageListWidget(
            userId: 1,
            chat: Chat(
              name: "cleber",
              image: Image.asset(""),
              id: 12,
              users: [],
              messages: [
                Message(sender: User(id: 1, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber aujisdhaushdasuh duasdhuashadsuhadshdasdsuahudsahudsahudsahuhudsahusdahudsahuasdhuhsaudhuasduhdsahudsahuyhuydsahudsahudsahuhudsahudashudsahudsahuhdas"),
                Message(sender: User(id: 1, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber aujisdhaushdasuh duasdhuashadsuhadshdasdsuahudsahudsahudsahuhudsahusdahudsahuasdhuhsaudhuasduhdsahudsahuyhuydsahudsahudsahuhudsahudashudsahudsahuhdas"),
                Message(sender: User(id: 1, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber aujisdhaushdasuh duasdhuashadsuhadshdasdsuahudsahudsahudsahuhudsahusdahudsahuasdhuhsaudhuasduhdsahudsahuyhuydsahudsahudsahuhudsahudashudsahudsahuhdas"),
                Message(sender: User(id: 1, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber aujisdhaushdasuh duasdhuashadsuhadshdasdsuahudsahudsahudsahuhudsahusdahudsahuasdhuhsaudhuasduhdsahudsahuyhuydsahudsahudsahuhudsahudashudsahudsahuhdas"),
                Message(sender: User(id: 2, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber"),
                Message(sender: User(id: 2, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber"),
                Message(sender: User(id: 2, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber"),
                Message(sender: User(id: 2, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber"),
                Message(sender: User(id: 2, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber"),
                Message(sender: User(id: 2, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber"),
                Message(sender: User(id: 2, name: "pidrow", profilePicture: ""), insertedAt: DateTime.now(), groupId: 11, id: 1, content: "cleber"),
              ]),
        )),
          ChatInputWidget(onSubmit: (input) => 
            _socket.pushMessage(MessagePushPayload(content: input, groupId: 11))
          )
        ],
      )
    );
    
  }
}
