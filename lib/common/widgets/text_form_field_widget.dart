import 'package:flutter/material.dart';
import 'package:flutter_project/constants/sizes.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final String? Function(String?) validator;

  const TextFormFieldWidget({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText ?? false,
      autocorrect: false,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w600,
        ),
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.size30),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.size30),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.size30),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(Sizes.size30),
        ),
      ),
      validator: (value) => validator.call(value),
    );
  }
}
