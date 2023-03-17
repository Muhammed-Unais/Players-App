import 'package:flutter/material.dart';

class Snackbars {
  static snackBar(context, String content) {
    final snackbar = SnackBar(
      duration: const Duration(milliseconds: 950),
      backgroundColor: Colors.black,
      content: Text(
        content,
        style: const TextStyle(color: Colors.white),
      ),
    );
    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}