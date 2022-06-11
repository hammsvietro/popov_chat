import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/user.dart';
import 'package:popov_chat/theme.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({
    super.key,
  });

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {

  final _formKey = GlobalKey<FormState>();
  final _registerRequest = CreateChatRequest();
  final ImagePicker _picker = ImagePicker();
  Image? profilePicture;

  void submit() {

  }
    // First validate form.
 Future<void> _selectGroupImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      profilePicture = Image.file(File(image.path), height: 100,);
      setState(() {});
    }
 }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Create Group"),
          backgroundColor: ChatTheme.backgroundColor,
          foregroundColor: Colors.white,
        ),
        body: Center(
          child: SingleChildScrollView(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 340),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(labelText: "Group Name"),
                      onChanged: (value) => _registerRequest.name = value,
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      child: profilePicture != null ? profilePicture! : const SizedBox(),
                    ),
                    ElevatedButton(
                      onPressed: _selectGroupImage,
                      child: const Text("Select group image")
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
        )  
      )
    );
  }
}
