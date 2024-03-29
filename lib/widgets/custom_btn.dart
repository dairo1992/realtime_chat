import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget {
  final void Function()? onPressed;
  final String label;
  final Color color;

  const CustomBtn(
      {super.key, this.onPressed, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialButton(
        disabledColor: Colors.grey,
        elevation: 2,
        highlightElevation: 5,
        onPressed: onPressed,
        color: color,
        shape: const StadiumBorder(),
        child: Container(
          width: double.infinity,
          height: 50,
          child: Center(
            child: onPressed != null
                ? Text(
                    label,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  )
                : CircularProgressIndicator(
                    color: Colors.blue,
                  ),
          ),
        ),
      ),
    );
  }
}
