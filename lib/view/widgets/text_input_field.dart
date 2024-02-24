import 'package:flutter/material.dart';
import 'package:getx_tutorial/constant.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({super.key,required this.labelText,required this.controller,required this.icon,this.obscureText=false});

  final String labelText;
  final TextEditingController controller;
  final IconData icon;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon),
        labelStyle: const TextStyle(fontSize: 20),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: borderColor)),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(5),
          borderSide: const BorderSide(color: borderColor),
        ),
      ),
      obscureText: obscureText,
    );
  }
}
