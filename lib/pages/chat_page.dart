import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  List<ChatMessage> _messages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.white,
            title: Column(
              children: const [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  maxRadius: 13,
                  child: Text('Te', style: TextStyle(fontSize: 12)),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  'Dairo Barrio',
                  style: TextStyle(color: Colors.black87, fontSize: 12),
                )
              ],
            )),
        body: Container(
          child: Column(
            children: [
              Flexible(
                  child: ListView.builder(
                itemCount: _messages.length,
                physics: BouncingScrollPhysics(),
                reverse: true,
                itemBuilder: (_, int i) {
                  return _messages[i];
                },
              )),
              Divider(
                height: 1,
              ),
              Container(
                color: Colors.white,
                child: _inputChat(),
              )
            ],
          ),
        ));
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      child: Row(children: [
        Flexible(
            child: TextField(
          controller: _textController,
          onSubmitted: _handleSubmit,
          onChanged: (texto) {
            setState(() {
              if (texto.trim().length > 0) {
                _estaEscribiendo = true;
              } else {
                _estaEscribiendo = false;
              }
            });
          },
          decoration: InputDecoration.collapsed(hintText: 'Enviar mensaje'),
          focusNode: _focusNode,
        )),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          child: Platform.isIOS
              ? CupertinoButton(
                  child: Text('Enviar'),
                  onPressed: _estaEscribiendo
                      ? () => _handleSubmit(_textController.text.trim())
                      : null,
                )
              : Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: IconTheme(
                    data: IconThemeData(color: Colors.blue),
                    child: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      icon: const Icon(
                        FontAwesomeIcons.solidPaperPlane,
                      ),
                      onPressed: _estaEscribiendo
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    ),
                  )),
        )
      ]),
    ));
  }

  _handleSubmit(String texto) {
    if (texto.isEmpty) return;

    _textController.clear();
    _focusNode.requestFocus();

    final newMessage = ChatMessage(
        text: texto,
        uid: '123',
        animationCtr: AnimationController(
            vsync: this, duration: Duration(milliseconds: 400)));
    _messages.insert(0, newMessage);
    newMessage.animationCtr.forward();
    setState(() {
      _estaEscribiendo = false;
    });
  }

  @override
  void dispose() {
    // off del socket
    for (ChatMessage message in _messages) {
      message.animationCtr.dispose();
    }
    super.dispose();
  }
}
