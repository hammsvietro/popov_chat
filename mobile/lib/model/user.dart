import 'package:flutter/cupertino.dart';
import 'package:popov_chat/model/network.dart';
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
  Map<String, dynamic> toMap() {
    return {
      'password': password,
      'email': email,
    };
  }
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

class AuthenticationResponse extends ResponseBase {
  String? token;
  int? userId;
  
  AuthenticationResponse({
    required this.token,
    required this.userId,
    required bool success,
    required String? error
  }) : super(error: error, success: success);

  static AuthenticationResponse fromJSON(Map<String, dynamic> json) {
    return AuthenticationResponse(
      token: json["token"],
      userId: json["user_id"],
      success: json["success"],
      error: json["error"]
    );
  }
}

typedef LoginFormSubmitCallback = void Function(LoginRequest login);
typedef RegisterFormSubmitCallback = void Function(RegisterRequest register);
