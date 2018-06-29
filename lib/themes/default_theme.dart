import 'package:flutter/material.dart';
//import 'package:pigment/pigment.dart';

final ThemeData defaultTheme = _buildDefaultTheme();

ThemeData _buildDefaultTheme() {
  return ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.teal,
    primaryColor:
        Colors.teal, // /Pigment.fromString('#1EA198'); // Color(0xFF0175c2);
  );
}
