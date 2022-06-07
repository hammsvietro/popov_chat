class AuthStorage {
  String token;
  int userId;

  AuthStorage({required this.token, required this.userId});

  Map<String, dynamic> toMap() {
    return {
      "userId": userId,
      "token": token
    };
  }

  static AuthStorage fromMap(Map<String, dynamic> json) {
    return AuthStorage(
      token: json["token"],
      userId: json["userId"]
    );
  }
}