import 'package:flutter/Material.dart';

final borderFiled = OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: BorderSide(color: Colors.black));
final KStyle =
    TextStyle(fontSize: 19, fontWeight: FontWeight.bold, color: Colors.black);

InputDecoration buildDecoration(String name, IconData icon) {
  return InputDecoration(
      hintText: name,
      filled: true,
      fillColor: Colors.white,
      border: borderFiled,
      prefixIcon: Icon(icon));
}
