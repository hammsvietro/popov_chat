import 'package:flutter/cupertino.dart';
class User {
  String name;
  Image? profilePicture;
  int id;

  User({required this.name, required this.id, this.profilePicture});
}

class LoginRequest {
  String email;
  String password;
  LoginRequest({required this.email, required this.password});
}

typedef LoginFormSubmitCallback = void Function(LoginRequest login);

class RegisterRequest {
  String name;
  String password;
  String email;
  RegisterRequest({required this.name, required this.password, required this.email});
}