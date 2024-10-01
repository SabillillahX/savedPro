import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obsecureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obsecureText,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28.0),
      child: TextField(
        controller: controller,
        obscureText:
            obsecureText, // Controls text obscuring for password-like fields
        decoration: InputDecoration(
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color.fromARGB(255, 156, 155, 155)),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Color.fromARGB(255, 136, 135, 135)),
          ),
          fillColor: const Color.fromARGB(255, 217, 217, 217),
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 142, 142, 142)),
        ),
      ),
    );
  }
}
