import 'package:flutter/material.dart';
import 'package:flutter/services.dart';


class InputboxWithoutText extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;

  const InputboxWithoutText({
    Key? key,
    required this.label,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 4),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(52, 16, 96, 16),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
              inputFormatters: [
                FilteringTextInputFormatter.allow(
                  RegExp(r'[a-zA-ZığüşöçĞÜŞÖÇ\s\d]*'),
                ),
              ],
              decoration: InputDecoration(
                contentPadding:
                const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
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



/*class InputboxWithoutText extends StatelessWidget {
  final String label;
  final String hintText;
  final TextInputType keyboardType;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged; // <-- onChanged parametresi eklendi.

  const InputboxWithoutText({
    Key? key,
    required this.label,
    required this.hintText,
    required this.keyboardType,
    required this.controller,
    this.onChanged, // <-- onChanged parametresi eklendi.
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(width: 4),
        Expanded(
          //flex: 5,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(52, 16, 96, 16),
            child: TextField(
              controller: controller,
              keyboardType: keyboardType,
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
*/