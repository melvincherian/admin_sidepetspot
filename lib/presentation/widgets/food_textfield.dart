
// // ignore_for_file: use_key_in_widget_constructors

// import 'package:flutter/material.dart';

// class CustomfoodTextField extends StatelessWidget {
//   final TextEditingController controller;
//   final String label;
//   final String validationMessage;
//   final TextInputType keyboardType;
//   final VoidCallback? onTap;
//   final bool readOnly;

//   const CustomfoodTextField({
//     required this.controller,
//     required this.label,
//     required this.validationMessage,
//     this.keyboardType = TextInputType.text,
//     this.onTap,
//     this.readOnly = false,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//           padding: const EdgeInsets.all(10),
//       child: TextFormField(
//         controller: controller,
//         keyboardType: keyboardType,
//         readOnly: readOnly,
//         onTap: onTap, // Add onTap here
//         decoration: InputDecoration(
//           labelText: label,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//             enabledBorder: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(12),
//             borderSide: const BorderSide(color: Colors.teal, width: 1.5),
//           ),
//         ),
//         validator: (value) {
//           if (value == null || value.isEmpty) {
//             return validationMessage;
//           }
//           return null;
//         },
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';

class CustomFoodTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String validationMessage;
  final TextInputType? keyboardType;
  final bool readOnly;

  const CustomFoodTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.validationMessage,
    this.keyboardType,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return validationMessage;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
        contentPadding: const EdgeInsets.symmetric(horizontal: 12),
      ),
    );
  }
}

