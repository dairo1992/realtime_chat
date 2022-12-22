import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  final String label1;
  final String label2;
  final Color colorLabel1;
  final Color colorLabel2;
  final String ruta;

  const Labels({
    super.key,
    required this.label1,
    required this.label2,
    required this.colorLabel1,
    required this.colorLabel2,
    required this.ruta,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Text(label1,
              style: TextStyle(
                  color: colorLabel1,
                  fontSize: 15,
                  fontWeight: FontWeight.w300)),
          const SizedBox(
            height: 10,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushReplacementNamed(context, ruta);
            },
            child: Text(label2,
                style: TextStyle(
                    color: colorLabel2,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
          )
        ],
      ),
    );
  }
}
