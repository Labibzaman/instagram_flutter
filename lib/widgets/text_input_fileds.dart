import 'package:flutter/material.dart';

class MyTextFiled extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscure;
  final TextInputType keyboardType;

  const MyTextFiled(
      {super.key, required this.controller,
        required this.hintText,
         this.obscure=false,
        required this.keyboardType
      });

  @override
  Widget build(BuildContext context) {
    final outlineInputBorder =
        OutlineInputBorder(borderSide: Divider.createBorderSide(context));
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hintText,
        border: outlineInputBorder,
        focusedBorder: outlineInputBorder,
        enabledBorder: outlineInputBorder,
        filled: true,
        contentPadding: const EdgeInsets.all(8),
      ),
    );
  }
}
