import 'package:flutter/material.dart';

// Bu widget altı çizgili text button oluşturuyor
class MyTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const MyTextButton({
    Key? key,
    required this.text,
    required this.onPressed, required Color color, required Container child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        alignment: Alignment.bottomLeft,
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 0.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 17.0,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
