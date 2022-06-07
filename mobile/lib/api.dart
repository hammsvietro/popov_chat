import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:popov_chat/model/user.dart';

class ApiClient {
  static final ApiClient _apiClient = ApiClient._internal();
  final _dio = Dio();
  bool hasSetup = false;
  factory ApiClient() {
    return _apiClient;
  }
  Future<void> setup() async {
    Directory tempDir = await getTemporaryDirectory();
    var cookieJar = PersistCookieJar(
    ignoreExpires: true,
    persistSession: true,
    storage: FileStorage(tempDir.path)
  );
    _dio.interceptors.add(CookieManager(cookieJar));
    hasSetup = true;
  }
  ApiClient._internal();

  Future<AuthenticationResponse> registerUser(RegisterRequest request) async {
    if(!hasSetup) {
      await setup();
    }
    http.Response res = await http.post(
      Uri.parse('http://10.0.2.2:4000/api/user/register'),
      headers: {"Content-Type": "application/json"},
      body: json.encode(request.toMap())
    );
    
    return AuthenticationResponse.fromJSON(json.decode(res.body));
  }

  Future<AuthenticationResponse> loginUser(LoginRequest request) async {
    if(!hasSetup) {
      await setup();
    }
    var a = await _dio.post(
      'http://10.0.2.2:4000/api/token',
      data: request.toMap(),
    );
    
    return AuthenticationResponse.fromJSON(a.data!);
  }

  Future<void> listGroups() async {

    if(!hasSetup) {
      await setup();
    }
    var a = await _dio.get('http://10.0.2.2:4000/api/group/11');
    print(a.data);
  }
}
