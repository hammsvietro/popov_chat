import 'package:flutter/material.dart';
import 'package:popov_chat/func/validators.dart';
import 'package:popov_chat/model/user.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    required this.onSubmit,
    Key? key,
  }) : super(key: key);

  final RegisterFormSubmitCallback onSubmit;

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {

  final _formKey = GlobalKey<FormState>();
  final _registerRequest = RegisterRequest(email: '', password: '', nickname: '');

 void submit() {
    // First validate form.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save our form now.
      widget.onSubmit(_registerRequest);
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
                onChanged: (value) => _registerRequest.email = value,
              ),
              const Spacer(),
              TextFormField(
                decoration: const InputDecoration(labelText: "Nickname"),
                onChanged: (value) => _registerRequest.nickname = value,
              ),
              const Spacer(),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(labelText: "Password"),
                validator: validatePassword,
                onChanged: (value) => _registerRequest.password = value,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: submit,
                    child: const Text("Register")
                  )
                ),
              )
            ],
          ),
        ),
      );
  }
}