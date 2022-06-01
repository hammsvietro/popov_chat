import 'package:flutter/material.dart';
import 'package:popov_chat/main.dart';
import 'package:popov_chat/screens/login/screen.dart';

Map<String, Widget Function(BuildContext)> routes =  {
  '/': (context) => const HomePage(title: 'Popov Chat'),
  '/authenticate': (context) => const LoginScreen()
};