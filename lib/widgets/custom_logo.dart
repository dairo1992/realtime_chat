import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Logo extends StatelessWidget {
  final IconData faIcon;
  final Color primaryColor;
  final String label;
  final int v = 900;

  const Logo(
      {super.key,
      required this.faIcon,
      this.primaryColor = Colors.blue,
      required this.label});

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      width: 170,
      margin: const EdgeInsets.only(top: 50),
      child: Column(children: [
        FaIcon(
          faIcon,
          size: 150,
          color: primaryColor,
        ),
        Text(
          label,
          style: TextStyle(fontSize: 30, color: Colors.blue[900]),
        )
      ]),
    ));
  }
}
