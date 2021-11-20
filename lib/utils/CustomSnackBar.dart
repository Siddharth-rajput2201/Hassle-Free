import 'package:flutter/material.dart';

ScaffoldFeatureController customSnackBar(
    BuildContext context, String msg, Color snackBarColor) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: snackBarColor,
    ),
  );
}
