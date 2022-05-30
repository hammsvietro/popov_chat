import 'dart:math';

import 'package:flutter/material.dart';
import 'package:popov_chat/components/chat_preview.dart';
import 'package:popov_chat/screens/login/screen.dart';
import 'package:popov_chat/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Popov Chat',
      theme: ThemeData(
        primarySwatch: ChatTheme.primaryColor,
        scaffoldBackgroundColor: ChatTheme.backgroundColor,
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.white),
          hintStyle: TextStyle(color: Colors.white),
        ),
        textTheme: const TextTheme(
          bodyText2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.white),
          subtitle2: TextStyle(color: Colors.white),
          
        ),
      ),
      home: const MyHomePage(title: 'Popov Chat', init: 666),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final String title;
  final int init;
  const MyHomePage({Key? key, required this.title, required this.init}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    loadToken();
    _counter = widget.init;
  }

  loadToken() async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString("token");
    if(token == null) {
      pushLoginScreen();
    }
  }
  void pushLoginScreen() {
    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen(key: widget.key)));
  }


  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: ChatTheme.backgroundColor
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            ChatPreview(key: widget.key)
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ChatTheme.primaryColor,
        foregroundColor: ChatTheme.backgroundColor,
        splashColor: ChatTheme.primaryColor.shade800,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
