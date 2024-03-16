import 'package:flutter/material.dart';

class ErrorSnackBar {
  ErrorSnackBar({
    required this.message,
    required this.context,
  });
  final String message;
  final BuildContext context;

  void show() {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 3),
        content: Text(message,
            style: TextStyle(color: Theme.of(context).colorScheme.onError)),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
  }
}
