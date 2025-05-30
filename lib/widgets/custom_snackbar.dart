import 'package:flutter/material.dart';

void showCustomSnackBar({
  required BuildContext context,
  required String message,
  Color backgroundColor = Colors.black87,
  SnackBarBehavior behavior = SnackBarBehavior.floating,
  double borderRadius = 8,
  SnackBarAction? action,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      backgroundColor: backgroundColor,
      behavior: behavior,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(borderRadius),
      ),
      action: action,
    ),
  );
}
