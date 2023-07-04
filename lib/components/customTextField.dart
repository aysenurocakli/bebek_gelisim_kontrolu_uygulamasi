import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String text;
  final TextAlign textAlign;
  final TextStyle? textStyle;

  const CustomText({
    Key? key,
    required this.text,
    this.textAlign = TextAlign.center,
     this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.deepPurple, // set border color
            width: 2.5, // set border width
          ),
        ),
      ),
      child: Text(
        text,
        style: textStyle ?? const TextStyle(
        fontSize: 51,
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontFamily:'Montserrat',
      ),
        textAlign: textAlign,
      ),
    );
  }
}
