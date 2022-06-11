import 'dart:async';
import 'package:popov_chat/api.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/message.dart';
import 'package:rxdart/rxdart.dart';

class AppState {
  static final AppState _appState = AppState._singleton();
  factory AppState() {
    return _appState;
  }
  AppState._singleton();

  final _controller = BehaviorSubject();
  final _apiClient = ApiClient();

  Stream<void> getStateChangedStream() {
    return _controller.stream;
  }

  Future<void> setup() async {
    await reloadChats();
  }

  Future<void> reloadChats() async {
    clearState();
    chats.addAll(await _apiClient.listGroups());
  }

  final List<Chat> chats = [];

  void clearState() {
    chats.clear();
  }

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

  Future<void> getMoreMessages(int groupId) async {
    var chat = chats.firstWhere((chat) => chat.id == groupId);
    List<Message> newMessages = await _apiClient .getMessagesForGroup(groupId, chat.currentMessageChunk);
    if(newMessages.isEmpty) {
      chat.hasReadAllMessages = true;
    } else {
      chat.addMessages(newMessages);
      chat.currentMessageChunk++;
    }
    _controller.add(true);
  }

  void addMessage(Message message) {
    chats
      .firstWhere((chat) => chat.id == message.groupId)
      .addMessage(message);
    _controller.add(true);
  }
}
