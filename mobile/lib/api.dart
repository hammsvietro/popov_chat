import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/user.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiClient {
  static final ApiClient _apiClient = ApiClient._singleton();
  final _dio = Dio();
  bool hasSetup = false;
  factory ApiClient() {
    return _apiClient;
  }
  Future<void> setup() async {
    if(hasSetup) return;

    Directory tempDir = await getTemporaryDirectory();
    var cookieJar = PersistCookieJar(
      ignoreExpires: true,
      persistSession: true,
      storage: FileStorage(tempDir.path)
    );
    _dio.interceptors.add(CookieManager(cookieJar));
    hasSetup = true;
  }

  ApiClient._singleton();

  get _apiBase {
    return dotenv.env["REST_API_ADDRESS"];
  }

  Future<AuthenticationResponse> registerUser(RegisterRequest request) async {
    http.Response res = await http.post(
      Uri.parse('$_apiBase/api/user/register'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(request.toMap())
    );
    
    return AuthenticationResponse.fromJSON(json.decode(res.body));
  }

  Future<AuthenticationResponse> loginUser(LoginRequest request) async {
    var res = await _dio.post(
      '$_apiBase/api/token',
      data: request.toMap(),
    );
    
    return AuthenticationResponse.fromJSON(res.data!);
  }

  Future<List<Chat>> listGroups() async {
    var res = await _dio.get('$_apiBase/api/group');
    
    (res.data! as List)
      .forEach((x) => print(x["users"]));

    return (res.data as List)
      .map((x) => Chat.fromMap(x))
      .toList();
  }
}
