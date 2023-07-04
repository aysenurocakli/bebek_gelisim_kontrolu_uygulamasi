import 'package:flutter/material.dart';

class DropDownButton extends StatefulWidget {
  final TextEditingController? controller;

  const DropDownButton({Key? key, this.controller}) : super(key: key);

  @override
  State<DropDownButton> createState() => _DropDownButtonState();
}

class _DropDownButtonState extends State<DropDownButton> {
  String? _selectedMonth;
  List<String> _allMonths = [
    '1. Ay',
    '2. Ay',
    '3. Ay',
    '4. Ay',
    '5. Ay',
    '6. Ay',
    '7. Ay',
    '8. Ay',
    '9. Ay',
    '10. Ay',
    '11. Ay',
    '12. Ay',
  ];

  @override
  void initState() {
    super.initState();
    if (_allMonths.contains(widget.controller?.text)) {
      _selectedMonth = widget.controller?.text;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: DropdownButton<String>(
            dropdownColor: Colors.white,
            hint: Text('Ay Seçiniz'),
            icon: Icon(
              Icons.arrow_circle_down_rounded,
              size: 30,
            ),
            iconEnabledColor: Colors.black,
            style: TextStyle(
              color: Colors.black,
              fontSize: 20,
            ),
            borderRadius: BorderRadius.circular(30),
            elevation: 0,
            items: _allMonths
                .map(
                  (String currentMonth) => DropdownMenuItem(
                child: Text(currentMonth),
                value: currentMonth,
              ),
            )
                .toList(),
            value: _selectedMonth,
            onChanged: (String? newMonth) {
              setState(() {
                _selectedMonth = newMonth;
                widget.controller?.text = _selectedMonth ?? '';
              });
            },

          ),
        ),
      ),
    );
  }
}
