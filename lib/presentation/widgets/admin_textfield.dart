import 'package:flutter/material.dart';

class AdminTextfield extends StatelessWidget {
  final String labelText;
  final String hintText;
  final Icon prefixIcon;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool obscureText;

  const AdminTextfield({
    super.key,
    required this.labelText,
    required this.hintText,
    required this.prefixIcon,
    required this.controller,
    this.validator,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        labelText: labelText,
        hintText: hintText,
        prefixIcon: prefixIcon,
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }
}
