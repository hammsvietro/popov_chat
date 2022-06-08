import 'dart:async';

import 'package:flutter/material.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/message.dart';

class AppState {
  static final AppState _apiClient = AppState._singleton();
  factory AppState() {
    return _apiClient;
  }
  AppState._singleton();

  final _controller = StreamController<bool>();

  Stream<void> getStateChangedStream() {
    return _controller.stream.asBroadcastStream();
  }

  final List<Chat> chats = [Chat(
    name: "ovo",
    id: 11,
    users: [],
    messages: [],
    image: Image.asset("assets/images/prog_snob.png", width: 40)),
  ];

  List<Chat> addChat(Chat chat) {
    chats.add(chat);
    _controller.add(true);
    return chats; 
  }

  Chat getChat(int chatId) {
    return chats.firstWhere((chat) => chat.id == chatId);
  }

  List<Chat> addChats(List<Chat> chats) {
    this.chats.addAll(chats);
    _controller.add(true);
    return this.chats; 
  }

  Chat addMessage(Message message) {
    var chat = chats.firstWhere((chat) => chat.id == message.groupId);
    chat.messages.add(message);
    _controller.add(true);
    return chat;
  }
}
