import 'package:flutter/material.dart';

// Renkli rounded button
class RoundedButton extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final VoidCallback onPressed;

  const RoundedButton({super.key,
    required this.text,
    required this.color,
    required this.textColor,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(color),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            fontFamily: 'Caviar Dreams',
            color: textColor,
          ),
        ),
      ),
    );
  }
}
