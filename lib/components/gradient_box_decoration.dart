import 'package:flutter/material.dart';

BoxDecoration buildGradientBoxDecoration() {
  return BoxDecoration(
    gradient: LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [Colors.purple, Colors.blue],
    ),
  );
}
