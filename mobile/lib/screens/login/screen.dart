import 'package:flutter/material.dart';
import 'package:popov_chat/api.dart';
import 'package:popov_chat/func/auth.dart';
import 'package:popov_chat/model/user.dart';
import 'package:popov_chat/screens/login/login_form.dart';
import 'package:popov_chat/screens/login/register_form.dart';
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

  void _onLoginFormSubmit(LoginRequest login) async {
    print(login.toMap());
    var authResponse = await loginUser(login);
    print(authResponse.success);
    print(authResponse.token);
    if (authResponse.success) {
      await saveToken(authResponse.token!);
      _goToMainScreen();
    }
  }
  
  void _onRegisterFormSubmit(RegisterRequest register) async {
    var authResponse = await registerUser(register);
    if (authResponse.success) {
      await saveToken(authResponse.token!);
      _goToMainScreen();
    }
  }

  void _goToMainScreen() {
      Navigator.pushNamedAndRemoveUntil(context, '/', (_) => false);
  }

  get _switchButtonText {
    return isRegistering
      ? "Already have an account? Click here!"
      : "Don't have an account? Click here!";
  }

  get _targetForm {
    return isRegistering
      ? RegisterForm(onSubmit: _onRegisterFormSubmit)
      : LoginForm(onSubmit: _onLoginFormSubmit);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: ChatTheme.backgroundColor, foregroundColor: Colors.white,),
      body: Center(
        key: widget.key,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _targetForm,
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    isRegistering = !isRegistering;
                  });
                },
                child: Text(
                  _switchButtonText,
                  style: const TextStyle(color: ChatTheme.primaryColor)
                ),
              )
            )
          ],
        )
      ),
    );
  }
}
