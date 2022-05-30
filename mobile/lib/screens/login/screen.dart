import 'package:flutter/material.dart';
import 'package:popov_chat/model/user.dart';
import 'package:popov_chat/screens/login/login_form.dart';
import 'package:popov_chat/theme.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRegistering = false;
  get title {
    return isRegistering ? "Register" : "Login";
  }

  void _onLoginFormSubmit(LoginRequest login) {
    print(login.email);
    print(login.password);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: ChatTheme.backgroundColor, foregroundColor: Colors.white,),
      body: Center(
        key: widget.key,
        child: LoginForm(onSubmit: _onLoginFormSubmit)
      ),
    );
  }
}
