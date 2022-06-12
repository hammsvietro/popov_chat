import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
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
  final ImagePicker _picker = ImagePicker();
  Image? profilePicture;

 void submit() {
    // First validate form.
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Save our form now.
      widget.onSubmit(_registerRequest);
    }
  }

 Future<void> _selectProfilePicture() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      _registerRequest.profilePicture = file;
      profilePicture = Image.file(file, height: 100,);
      setState(() {});
    }
 }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 300),
      child: SingleChildScrollView(
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
              TextFormField(
                decoration: const InputDecoration(labelText: "Nickname"),
                onChanged: (value) => _registerRequest.nickname = value,
              ),
              TextFormField(
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
                decoration: const InputDecoration(labelText: "Password"),
                validator: validatePassword,
                onChanged: (value) => _registerRequest.password = value,
              ),

              Container(
                padding: const EdgeInsets.symmetric(vertical: 40),
                child: profilePicture != null ? profilePicture! : const SizedBox(),
              ),
              
              ElevatedButton(
                onPressed: _selectProfilePicture,
                child: const Text("Select profile picture")
              ),
              const SizedBox(height: 40),
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
      )  
    );
  }
}
