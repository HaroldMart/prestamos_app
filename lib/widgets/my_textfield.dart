import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final controller;
  final String placeHolder;
  final bool obscureText;
  final String label;

  const MyTextField({
    super.key,
    required this.controller,
    required this.placeHolder,
    required this.obscureText,
    this.label = "",
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 210, 210, 210)),
            borderRadius: BorderRadius.circular(8.0)
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Color.fromARGB(255, 88, 63, 255)),
            borderRadius: BorderRadius.circular(8.0),
          ),
          fillColor: const Color.fromARGB(255, 255, 255, 255),
          filled: true,
          label: Text(label, style: const TextStyle(color: Color.fromARGB(255, 177, 177, 177)),),
          hintText: placeHolder,
          hintStyle: const TextStyle(color: Color.fromARGB(255, 105, 105, 105))),
    );
  }
}

class TextInput extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData? icon;

  const TextInput(
      {super.key,
      required this.controller,
      this.hintText = '',
      this.obscureText = false,
      this.icon});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        width: 350,
        decoration: BoxDecoration(
          color: const Color(0xFFEAEAEA),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            contentPadding: const EdgeInsets.symmetric(horizontal: 17.0),
            border: InputBorder.none,
            suffixIcon: icon != null
                ? Icon(
                    icon,
                    color: const Color(0xFF858585),
                  )
                : null,
          ),
        ),
      ),
    );
  }
}
