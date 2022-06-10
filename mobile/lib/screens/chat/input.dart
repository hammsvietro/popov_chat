import 'dart:io';

import 'package:flutter/material.dart';
import 'package:popov_chat/theme.dart';

class ChatInputWidget extends StatefulWidget {
  final void Function(String) onSubmit;
  const ChatInputWidget({Key? key, required this.onSubmit}) : super(key: key);

  @override
  State<ChatInputWidget> createState() => _ChatInputWidgetState();
}

class _ChatInputWidgetState extends State<ChatInputWidget> {
  String? _input;
  final _controller = TextEditingController();
  get _bottomMargin {
    return Platform.isAndroid ? 8.0 : 28.0;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 10, right: 10, bottom: _bottomMargin),
      child: Row(
        children: [
            Expanded(child: Container(
                padding: const EdgeInsets.only(left: 12, right: 12),
                margin: const EdgeInsets.only(right: 10),
                decoration: const BoxDecoration(
                  color: ChatTheme.surfaceColor,
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [BoxShadow(
                    blurRadius: 3.0,
                    offset: Offset(3.0, 3.0),
                  )]
                ),
                child: TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.multiline,
                  minLines: 1,
                  maxLines: 5,
                  textAlignVertical: TextAlignVertical.center,
                  decoration: const InputDecoration(
                    labelText: "Type something",
                    contentPadding: EdgeInsets.only(bottom: 16),
                    floatingLabelBehavior: FloatingLabelBehavior.never,
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                  style: TextStyle(fontSize: 14),
                  onChanged: (value) => _input = value,
                  controller: _controller,
                ),
              ),
            ),
            SizedBox.fromSize(
              size: const Size(35, 35), // button width and height
              child: ClipOval(
                child: Material(
                  color: ChatTheme.primaryColor, // button color
                  child: InkWell(
                    onTap: () {
                      if(_input != null) {
                        widget.onSubmit(_input!);
                        _input = null;
                        _controller.clear();
                      }
                    }, // button pressed
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const <Widget>[
                        Icon(Icons.send), // icon
                      ],
                    ),
                  ),
                ),
              ),
            )
          ])
    );
  }
}
