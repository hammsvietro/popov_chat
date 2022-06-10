import 'package:flutter/material.dart';
import 'package:popov_chat/main.dart';
import 'package:popov_chat/screens/chat/screen.dart';
import 'package:popov_chat/screens/login/screen.dart';

Map<String, Widget Function(BuildContext)> routes =  {
  '/': (context) => const HomePage(title: 'Popov Chat'),
  '/chat': (context) => const ChatWidget(),
  '/authenticate': (context) => const LoginScreen()
};
