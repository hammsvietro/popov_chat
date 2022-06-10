import 'dart:async';

import 'package:flutter/material.dart';
import 'package:popov_chat/func/auth.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/screens/chat/input.dart';
import 'package:popov_chat/screens/chat/message_list.dart';
import 'package:popov_chat/socket.dart';
import 'package:popov_chat/state.dart';
import 'package:popov_chat/theme.dart';

class ChatWidgetArguments {
  int groupId;
  ChatWidgetArguments({required this.groupId});
}

class ChatWidget extends StatefulWidget {
  const ChatWidget({Key? key}) : super(key: key);

  @override
  State<ChatWidget> createState() => _ChatWidgetState();
}

class _ChatWidgetState extends State<ChatWidget> {
  late Chat _chat;
  late int _userId;
  bool hasLoaded = false;
  StreamSubscription? _stateChangedSub;
  final SocketClient _socket = SocketClient();
  late int _groupId;

  Future<void> loadChat() async {
    _userId = (await getAuth())!.userId;
    print(_userId);
    await AppState().getMoreMessages(_groupId);
    setState(() {
      _chat = AppState().getChat(_groupId);
      hasLoaded = true;
    });
  }

  @override
  void initState() {
    _stateChangedSub = AppState()
      .getStateChangedStream()
      .listen(
        (_) => setState(() {})
      );
    super.initState();
  }

  @override
  void dispose() {
    _stateChangedSub?.cancel();
    super.dispose();
  }

  Future<bool> _onWillPop() async {
    _stateChangedSub?.cancel();
    return true;
  }

  get _mainWidget {
    if(!hasLoaded) {
      return Container();
    } else {
      return WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(

          appBar: AppBar(
            leadingWidth: 20,
            title: Row(children: [
              Container(
                width: 50,
                margin: const EdgeInsets.only(right: 6),
                child: CircleAvatar(
                  backgroundImage: NetworkImage(_chat.image)
                ),
              ),
              Text(_chat.name),
            ]),
            backgroundColor: ChatTheme.backgroundColor,
            foregroundColor: Colors.white,
          ),
          body: Column(
            children: [
              Expanded(
                child: MessageListWidget(
                  userId: _userId,
                  chat:_chat
                )
              ),
              ChatInputWidget(
                onSubmit: (input) {
                  _socket.pushMessage(MessagePushPayload(content: input, groupId: _groupId));
                }
              )
            ],
          )
        )
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if(!hasLoaded) {
      _groupId = ((ModalRoute.of(context))!.settings.arguments as ChatWidgetArguments).groupId;
      loadChat();
    }
    return _mainWidget;
    
  }
}
