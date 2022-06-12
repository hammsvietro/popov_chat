import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:popov_chat/api.dart';
import 'package:popov_chat/model/chat.dart';
import 'package:popov_chat/model/user.dart';
import 'package:popov_chat/routes.dart';
import 'package:popov_chat/screens/chat/screen.dart';
import 'package:popov_chat/state.dart';
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

  Future<void> submit() async {
    if(!_formKey.currentState!.validate()) return;

    var chat = await ApiClient().createGroup(_registerRequest);
    await AppState().reloadChats();
    _removeCurrentPageFromstack();
    _goToChatPage(chat.id);
  }
    // First validate form.
 Future<void> _selectGroupImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      File file = File(image.path);
      _registerRequest.image = file;
      profilePicture = Image.file(file, height: 100,);
      setState(() {});
    }
 }

  _goToChatPage(int groupId) {
    Navigator.pushNamed(
        context,
        '/chat',
        arguments: ChatWidgetArguments(groupId: groupId));
  }

  _removeCurrentPageFromstack() {
    Navigator.removeRoute(context, materialRoutes['/create-group']!);
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
                      validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
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
                          child: const Text("Create Group")
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
