import 'package:flutter/material.dart';
import 'package:popov_chat/theme.dart';

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
        primarySwatch: ChatTheme.chatPrimarySwash,
        scaffoldBackgroundColor: ChatTheme.chatPrimarySwash,
        textTheme: const TextTheme(
          headline1: TextStyle(color: Colors.white),
          headline2: TextStyle(color: Colors.white),
          headline4: TextStyle(color: Colors.white),
          bodyText2: TextStyle(color: Colors.white),
          subtitle1: TextStyle(color: Colors.pinkAccent),
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
    _counter = widget.init;
  }


  void _incrementCounter() {
    setState(() => _counter++);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: ChatTheme.primaryColor,
        foregroundColor: ChatTheme.chatPrimarySwash,
        splashColor: ChatTheme.primaryColor.shade800,
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
