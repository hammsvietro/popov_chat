import 'package:flutter/material.dart';
import 'package:popov_chat/func/validators.dart';
import 'package:popov_chat/model/user.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final LoginFormSubmitCallback onSubmit;

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {

  final _formKey = GlobalKey<FormState>();
  final _loginRequest = LoginRequest(email: '', password: '');

 void submit() {
    // First validate form.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save our form now.
      widget.onSubmit(_loginRequest);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: 300,
        height: 300,
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: "E-mail"
                  
                ),
                validator: validateEmail,
                onChanged: (value) => _loginRequest.email = value,
              ),
              const Spacer(),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(labelText: "Password"),
                validator: validatePassword,
                onChanged: (value) => _loginRequest.password = value,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child:
                  ElevatedButton(
                    onPressed: submit,
                    child: const Text("Login")
                  ),
              )
            ],
          ),
        ),
      );
  }
}