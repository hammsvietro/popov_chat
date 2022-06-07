import 'package:flutter/material.dart';
import 'package:popov_chat/api.dart';
import 'package:popov_chat/components/chat_preview_list.dart';
import 'package:popov_chat/func/auth.dart';
import 'package:popov_chat/routes.dart';
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
      routes: routes,
    );
  }
}

class HomePage extends StatefulWidget {
  final String title;
  const HomePage({Key? key, required this.title}) : super(key: key);

  @override
  State<HomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<HomePage> {
  @override
  void initState() {
    loadToken();
    super.initState();
  }


  loadToken() async {
    var token = await getAuth();
    if(token == null) {
      goToLoginScreen();
    } else {
      var a = ApiClient();
      a.listGroups();
    }

  }

  void goToLoginScreen() {
    Navigator.pushNamedAndRemoveUntil(context, '/authenticate', (_) => false);
  }

  void _doLogout() async {
    bool hasRemoved = await removeAuth();
    if(hasRemoved) {
      goToLoginScreen();
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: ChatTheme.backgroundColor,
        foregroundColor: Colors.white,
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                const PopupMenuItem<int>(
                    value: 0,
                    child: Text("New group", style: TextStyle(color: Colors.black)),
                ),
                const PopupMenuItem<int>(
                    value: 1,
                    child: Text("Logout", style: TextStyle(color: Colors.black)),
                ),
              ];
            },
            onSelected: (value){
              if(value == 1){
                 _doLogout(); 
              }
            }
          )
        ],
      ),
      body: ChatPreviewList(key: widget.key));
  }
}
