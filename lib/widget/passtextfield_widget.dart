import 'package:expatretail/core.dart';
import 'package:flutter/material.dart';

class PassTextFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final String upText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  const PassTextFieldWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.upText,
    required this.validator,
    required this.onChanged,
  });

  @override
  _PassTextFieldWidgetState createState() => _PassTextFieldWidgetState();
}

class _PassTextFieldWidgetState extends State<PassTextFieldWidget> {
  bool _obscureText = true;

  void _toggleObscureText() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    String uptext = widget.upText;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: TextWidget(
              uptext,
              13,
              Colors.white,
              FontWeight.normal,
              letterSpace: 0,
              textAlign: TextAlign.left,
            ),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: widget.controller,
            obscureText: _obscureText,
            onChanged: widget.onChanged,
            validator: widget.validator,
            decoration: InputDecoration(
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
              ),
              fillColor: Colors.black,
              filled: true,
              hintText: widget.hintText,
              hintStyle: const TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                  fontWeight: FontWeight.normal),
              suffixIcon: IconButton(
                onPressed: _toggleObscureText,
                icon: Icon(
                  _obscureText ? Icons.visibility : Icons.visibility_off,
                  color: Colors.grey,
                ),
              ),
            ),
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
