import 'package:flutter/material.dart';

InputDecoration customInputDecoration(
  String hint, {
  IconData? icon,
  Widget? suffixIcon,
}) {
  return InputDecoration(
    hintText: hint,
    suffixIcon: suffixIcon,
    hintStyle: const TextStyle(color: Color.fromARGB(255, 255, 255, 255), fontSize: 14),
    contentPadding: const EdgeInsets.symmetric(horizontal: 6, vertical: 14),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(8),
      borderSide: const BorderSide(color: Colors.white),
    ),
    prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
  );
}
