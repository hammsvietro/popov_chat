import 'package:flutter/material.dart';
import 'package:popov_chat/theme.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isRegistering = false;
  String? name;
  String? email;
  String? password;
  final _formKey = GlobalKey<FormState>();
  final emailRegex = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  get title {
    return isRegistering ? "Register" : "Login";
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Required";
    if (!emailRegex.hasMatch(value)) return "The E-mail Address must be a valid email address.";
    return null;
  }

 void submit() {
    // First validate form.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save our form now.
      print('Printing the login data.');
      print('Email: ${email}');
      print('Password: ${password}');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), backgroundColor: ChatTheme.backgroundColor, foregroundColor: Colors.white,),
      body: Center(
        key: widget.key,
        child: SizedBox(
          width: 300,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: "E-mail"
                  ),
                  validator: _validateEmail
                ),
                ElevatedButton(onPressed: submit, child: const Text("Submit"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
