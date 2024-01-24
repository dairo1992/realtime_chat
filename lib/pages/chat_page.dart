import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:realtime_chat/services/auth_services.dart';
import 'package:realtime_chat/services/chat_service.dart';
import 'package:realtime_chat/services/socket_services.dart';
import 'package:realtime_chat/widgets/widgets.dart';

class ChatPage extends StatefulWidget {
  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  bool _estaEscribiendo = false;
  late ChatService chatService;
  late SocketService socketService;
  late AuthServices authServices;
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    chatService = Provider.of<ChatService>(context, listen: false);
    socketService = Provider.of<SocketService>(context, listen: false);
    authServices = Provider.of<AuthServices>(context, listen: false);
    socketService.socket.on('mensaje-personal', _escucharMensaje);
  }

  void _escucharMensaje(dynamic data) {
    ChatMessage message = ChatMessage(
        text: data['mensaje'],
        uid: data['de'],
        animationCtr: AnimationController(
            vsync: this, duration: Duration(milliseconds: 300)));

    setState(() {
      _messages.insert(0, message);
    });
    message.animationCtr.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            elevation: 1,
            backgroundColor: Colors.white,
            title: Column(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.blueAccent,
                  maxRadius: 13,
                  child: Text(chatService.usuarioPara.nombre.substring(0, 2),
                      style: TextStyle(fontSize: 12)),
                ),
                SizedBox(
                  height: 3,
                ),
                Text(
                  chatService.usuarioPara.nombre,
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

    // socketService.socket.emit('mensaje-personal', {
    //   'de': authServices.dataUsuario.uid,
    //   'para': chatService.usuarioPara.uid,
    //   'mensaje': texto
    // });
    socketService.emit('mensaje-personal', {
      'de': authServices.dataUsuario.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': texto
    });
    socketService.socket.emit('mensaje-personal', {
      'de': authServices.dataUsuario.uid,
      'para': chatService.usuarioPara.uid,
      'mensaje': texto
    });
  }

  @override
  void dispose() {
    // off del socket
    for (ChatMessage message in _messages) {
      message.animationCtr.dispose();
    }
    socketService.socket.off('mensaje-personal');
    super.dispose();
  }
}
