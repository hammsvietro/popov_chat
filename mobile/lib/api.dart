import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:popov_chat/model/user.dart';

Future<void> registerUser(RegisterRequest request) async {
  http.Response res = await http.post(
    Uri.parse('http://10.0.2.2:4000/api/user/register'),
    headers: {"Content-Type": "application/json"},
    body: json.encode(request.toMap())
  );
}