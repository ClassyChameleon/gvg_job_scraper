import 'package:flutter/material.dart';

// The AppBar to be used for all pages
class ButtonPreset extends StatelessWidget {
  const ButtonPreset(
      {Key? key,
      required this.onPressed,
      required this.childText,
      this.textStyle = const TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      )})
      : super(key: key);

  final Function()? onPressed;
  final String childText;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        elevation: 4,
        padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
      ),
      child: Text(childText, style: textStyle),
    );
  }
}
