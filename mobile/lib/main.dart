import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:popov_chat/api.dart';
import 'package:popov_chat/components/chat_preview_list.dart';
import 'package:popov_chat/func/auth.dart';
import 'package:popov_chat/routes.dart';
import 'package:popov_chat/socket.dart';
import 'package:popov_chat/state.dart';
import 'package:popov_chat/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  try {
    await ApiClient().setup();
    await SocketClient().setup();
    await AppState().setup();
  } catch(e) {
    await removeAuth();
  }
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
    }
  }

  void goToLoginScreen() {
    Navigator.pushNamedAndRemoveUntil(context, '/authenticate', (_) => false);
  }

  void _goToNewGroup() async {
    Navigator.push(context, materialRoutes['/create-group']!);
  }

  void _goToFindGroup() async {
    Navigator.push(context, materialRoutes['/find-groups']!);
  }

  void _doLogout() async {
    bool hasRemoved = await removeAuth();
    if(hasRemoved) {
      SocketClient().disconnect();
      AppState().clearState();
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
                    child: Text("Find a group", style: TextStyle(color: Colors.black)),
                ),
                const PopupMenuItem<int>(
                    value: 2,
                    child: Text("Logout", style: TextStyle(color: Colors.black)),
                ),
              ];
            },
            onSelected: (value){
              if(value == 0) {
                _goToNewGroup();
              }
              if(value == 1) {
                _goToFindGroup();
              }
              if(value == 2){
                 _doLogout(); 
              }
            }
          )
        ],
      ),
      // body: ChatWidget(key: widget.key, groupId: 11,));
      body: const ChatPreviewList(mode: ChatPreviewMode.joined,));
  }
}
