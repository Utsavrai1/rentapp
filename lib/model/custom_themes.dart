import 'package:flutter/material.dart';

class CustomTheme {
  ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      fontFamily: 'DM Sans',
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.blue,
        primary: Colors.blue,
      ),
      scaffoldBackgroundColor: Colors.grey[50],
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey[50],
        elevation: 0,
        centerTitle: true,
        titleTextStyle: const TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w700,
          color: Colors.black,
        ),
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
    );
  }
}
