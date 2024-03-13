import 'package:flutter/material.dart';

showErrorSnackbar(
  BuildContext context,
  String message,
) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      backgroundColor: const Color.fromRGBO(205, 6, 16, 0.894),
      content: Text(
        message,
        style: const TextStyle(
          color:Colors.white,
          fontSize: 16
        ),
      ),
    ),
  );
}
