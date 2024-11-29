import 'package:flutter/material.dart';

class CustomDescriptionTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String validationMessage;
  final int? minLines; // Minimum number of lines
  final int? maxLines; // Maximum number of lines
  final TextInputType keyboardType;

  const CustomDescriptionTextField({
    required this.controller,
    required this.label,
    required this.validationMessage,
    this.minLines = 1, // Default to single line
    this.maxLines = 5, // Set a higher limit for multiple lines
    this.keyboardType = TextInputType.text, // Default to text keyboard
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        minLines: minLines, // Minimum lines (height starts at 1 line)
        maxLines: maxLines, // Maximum lines (adjustable based on content)
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Colors.teal, width: 1.5),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 17.0, horizontal: 15.0),
        ),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return validationMessage;
          }
          return null;
        },
      ),
    );
  }
}

