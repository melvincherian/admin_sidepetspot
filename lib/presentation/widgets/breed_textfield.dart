// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class BreedTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String validationMessage;
  final TextInputType keyboardType;

  const BreedTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.validationMessage,
    this.keyboardType = TextInputType.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10)
          ),
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
