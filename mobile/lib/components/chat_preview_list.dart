import 'package:flutter/material.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:popov_chat/components/chat_preview.dart';
import 'package:popov_chat/func/auth.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/model/user.dart';

class ChatPreviewList extends StatefulWidget {
  const ChatPreviewList({Key? key}) : super(key: key);
   
  @override
  State<ChatPreviewList> createState() => _ChatPreviewListState();
} 

class _ChatPreviewListState extends State<ChatPreviewList> {

  @override
  void initState() {
    super.initState();
    connectPhoenix();
  }

  connectPhoenix() async {
    var authStorage = await getAuth();
    final socket = PhoenixSocket("ws://10.0.2.2:4000/socket/websocket",  socketOptions: PhoenixSocketOptions(params: {"user_token":  authStorage!.token}));
    await socket.connect();
    final chatChannel = socket.channel("chat:${authStorage.userId}", {});
    chatChannel.on("message", ((payload, ref, joinRef) {print("new message!");print(payload);}));
    chatChannel.join();
    /*
    chatChannel.push(event: "ping")!.receive("ok", (response) {
      print(response);
    });
    */
  }
  List<ChatPreview> chats = [
  ChatPreview(
    image: Image.asset("assets/images/prog_snob.png", width: 40),
      name: 'poprog',
      lastMessage: Message(
        sender: User(id: 1, name: 'Popov'), dateSent: DateTime.now(),
        content: 'Ouçam haken'
      )
    ),
  ChatPreview(
    image: Image.asset("assets/images/prog_snob.png", width: 40),
      name: 'futebol do popov',
      lastMessage: Message(
        sender: User(id: 1, name: 'Popov'), dateSent: DateTime.now(),
        content: 'fiz 4 embaixadinhas antes de ontem.'
      )
    ),
  ];
  
  List<Widget> _renderChatPreviews() {
    return chats.map(
      (ChatPreview chatPreview) => ChatPreviewComponent(chatPreview: chatPreview)
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListView(
          shrinkWrap: true,
          children: _renderChatPreviews()
        ),
      ],
    );
  }
}

