import 'dart:convert';

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

class RegisterRequest {
  String nickname;
  String password;
  String email;
  RegisterRequest({required this.nickname, required this.password, required this.email});
  Map<String, dynamic> toMap() {
    return {
      'nickname': nickname,
      'password': password,
      'email': email,
    };
  }
}

typedef LoginFormSubmitCallback = void Function(LoginRequest login);
typedef RegisterFormSubmitCallback = void Function(RegisterRequest register);
