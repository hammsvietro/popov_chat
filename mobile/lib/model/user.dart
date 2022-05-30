import 'package:flutter/cupertino.dart';

class User {
  String name;
  Image? profilePicture;
  int id;

  User({required this.name, required this.id, this.profilePicture});
}
