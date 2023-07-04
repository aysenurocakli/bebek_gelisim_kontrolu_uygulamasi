import 'package:flutter/material.dart';
class TextWithInputbox extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final int? maxLength;
  final ValueChanged<String>? onChanged; // <-- onChanged parametresi eklendi.

  const TextWithInputbox({
    Key? key,
    required this.label,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.maxLength,
    this.onChanged, // <-- onChanged parametresi eklendi.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 5,
          child: Padding(
              padding: const EdgeInsets.only(left: 54),
              child: Text(
              label,
              style: const TextStyle(fontSize: 19,fontStyle: FontStyle.normal,color: Colors.black87,),
            ),
          ),

        ),
        const SizedBox(width: 4),
        Expanded(
          flex: 5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 16, 48, 16),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              maxLength: maxLength,
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(vertical:10,horizontal:10),
                hintText: hintText,
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
              ),
              onChanged: onChanged,
            ),
          ),
        )
      ],
    );
  }
}
