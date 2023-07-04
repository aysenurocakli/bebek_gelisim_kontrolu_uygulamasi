
import 'package:flutter/material.dart';

class BackIconButton extends StatefulWidget {
  final VoidCallback onPressed;
  const BackIconButton({Key? key, required this.onPressed}) : super(key: key);

  @override
  State<BackIconButton> createState() => _BackIconButtonState();
}

class _BackIconButtonState extends State<BackIconButton> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed, // Assign the onPressed callback to the onTap of GestureDetector
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: const <Widget>[
          IconButton(
            icon: Icon(Icons.arrow_back_ios),
            tooltip: 'back',
            onPressed: null, // Set this to null since the GestureDetector handles the tap event
          ),
        ],
      ),
    );
  }
}
