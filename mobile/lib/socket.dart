import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:phoenix_wings/phoenix_wings.dart';
import 'package:popov_chat/func/auth.dart';
import 'package:popov_chat/model/message.dart';
import 'package:popov_chat/state.dart';

class SocketClient {
  static final SocketClient _apiClient = SocketClient._singleton();
  bool hasSetup = false;
  factory SocketClient() {
    return _apiClient;
  }
  SocketClient._singleton();

  Future<void> setup() async {
    if(hasSetup) return;
    await connectPhoenix();
    hasSetup=true;
  }

  late PhoenixSocket _socket;
  late PhoenixChannel _chatChannel;
  final _state = AppState();

  connectPhoenix() async {
    var authStorage = await getAuth();
    _socket = PhoenixSocket("${dotenv.env["SOCKET_ENDPOINT_ADDRESS"]}/socket/websocket",  socketOptions: PhoenixSocketOptions(params: {"user_token":  authStorage!.token}));
    await _socket.connect();
    _chatChannel = _socket.channel("chat:${authStorage.userId}", {});
    _subscribeToChat();
  }
  Future<void> _subscribeToChat() async {
    _chatChannel.on(
      "message",
      (payload, ref, joinRef) {
        Message message = Message.fromPayload(payload!);
        _state.addMessage(message);
      });
    _chatChannel.join();
    _chatChannel.push(
      event: "message",
      payload: {
        "content": "hello man",
        "groupId": 11,
      }
    );
  }

  void pushMessage(MessagePushPayload message) {
    _chatChannel.push(
      event: "message",
      payload: message.toPayload()
    );
  }
}
