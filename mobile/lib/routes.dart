import 'package:flutter/material.dart';
import 'package:popov_chat/main.dart';
import 'package:popov_chat/screens/chat/screen.dart';
import 'package:popov_chat/screens/create-group/screen.dart';
import 'package:popov_chat/screens/find-groups/screen.dart';
import 'package:popov_chat/screens/login/screen.dart';

Map<String, Widget Function(BuildContext)> routes = materialRoutes
  .map((key, value) => MapEntry(key, value.builder));

Map<String, MaterialPageRoute<dynamic>> materialRoutes =  {
  '/': MaterialPageRoute(builder: (context) => const HomePage(title: 'Popov Chat')),
  '/chat': MaterialPageRoute(builder:(context) => const ChatWidget()),
  '/find-groups': MaterialPageRoute(builder: (context) => const FindGroups()),
  '/authenticate': MaterialPageRoute(builder: (context) => const LoginScreen()),
  '/create-group': MaterialPageRoute(builder: (context) => const CreateGroup()) 
};
