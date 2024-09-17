import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

class TextFieldComplaint extends StatelessWidget {
  final TextEditingController controller;
  final String upText;
  final String hintText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const TextFieldComplaint({
    super.key,
    required this.controller,
    required this.upText,
    required this.hintText,
    required this.obscureText,
    required this.validator,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: [
        Container(
          alignment: Alignment.centerLeft,
          child: TextWidget(
            upText,
            13,
            Colors.white,
            FontWeight.normal,
            letterSpace: 0,
            textAlign: TextAlign.left,
          ),
        ),
        const SizedBox(height: 5),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          decoration: InputDecoration(
            enabledBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            fillColor: Colors.black,
            filled: true,
            hintText: hintText,
            hintStyle: const TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.normal),
          ),
          style: const TextStyle(color: Colors.white),
          maxLines: 3,
        ),
      ]),
    );
  }
}
