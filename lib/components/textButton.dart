import 'package:flutter/material.dart';

//altı çizgisisz text button
class CustomTextButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color buttonColor;
  final Color textColor;
  final double fontSize;
  final double padding;
  final double borderRadius;
  final TextAlign textAlign; // Add the TextAlign property

  const CustomTextButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.buttonColor = Colors.transparent,
    this.textColor = Colors.white,
    this.fontSize = 18.0,
    this.padding = 16.0,
    this.borderRadius = 8.0,
    this.textAlign = TextAlign.center, // Set the default value
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: buttonColor,
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onPressed,
          child: Padding(
            padding: EdgeInsets.all(padding),
            child: Text(
              text,
              style: TextStyle(
                fontSize: fontSize,
                color: textColor,
              ),
              textAlign: textAlign, // Use the TextAlign property
            ),
          ),
        ),
      ),
    );
  }
}
