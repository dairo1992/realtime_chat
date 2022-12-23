import 'package:flutter/material.dart';

class ChatMessage extends StatelessWidget {
  final String text;
  final String uid;
  final AnimationController animationCtr;

  const ChatMessage(
      {super.key,
      required this.text,
      required this.uid,
      required this.animationCtr});

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationCtr,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationCtr, curve: Curves.easeOut),
        child: Container(
          child: uid == '123' ? _myMessage() : _message(),
        ),
      ),
    );
  }

  Widget _myMessage() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 50, right: 5),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Color(0xfff4D9Ef6), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }

  Widget _message() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.all(8.0),
        margin: EdgeInsets.only(bottom: 5, left: 5, right: 50),
        child: Text(
          text,
          style: TextStyle(color: Colors.black87),
        ),
        decoration: BoxDecoration(
            color: Color(0xfffE4E5E8), borderRadius: BorderRadius.circular(20)),
      ),
    );
  }
}
