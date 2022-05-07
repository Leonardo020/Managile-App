import 'package:flutter/material.dart';

class ErrorScaffoldMessenger {
  static SnackBar showErrorSnackBar(String content) {
    return SnackBar(
        backgroundColor: Colors.red,
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 18),
        ));
  }
}
