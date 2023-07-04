import 'package:flutter/material.dart';

class MyButtonGroup extends StatefulWidget {
  final String text1, text2;
  final Function(String?) onSelected;

  MyButtonGroup({
    required this.text1,
    required this.text2,
    required this.onSelected,
  });

  @override
  _MyButtonGroupState createState() => _MyButtonGroupState();
}

class _MyButtonGroupState extends State<MyButtonGroup> {
  int? _selectedIndex;

  String? getSelectedText() {
    if (_selectedIndex == 0) {
      return widget.text1;
    } else if (_selectedIndex == 1) {
      return widget.text2;
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        IconButton(
          onPressed: () {
            setState(() {
              _selectedIndex = 0;
            });
            widget.onSelected(getSelectedText());
          },
          icon: Icon(
            _selectedIndex == 0 ? Icons.circle : Icons.circle_outlined,
            color: _selectedIndex == 0 ? Colors.white : Colors.white,
          ),
          iconSize: 35.0,
        ),
        Text(
          widget.text1,
          style: TextStyle(fontSize: 21.0, color: Colors.white),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              _selectedIndex = 1;
            });
            widget.onSelected(getSelectedText());
          },
          icon: Icon(
            _selectedIndex == 1 ? Icons.circle : Icons.circle_outlined,
            color: _selectedIndex == 1 ? Colors.white : Colors.white,
          ),
          iconSize: 35.0,
        ),
        Text(
          widget.text2,
          style: TextStyle(fontSize: 21.0, color: Colors.white),
        ),
      ],
    );
  }
}
