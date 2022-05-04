import 'package:flutter/material.dart';

ScaffoldFeatureController customSnackBar(
    BuildContext context, String msg, Color snackBarColor) {
       double width = MediaQuery.of(context).size.width;
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      width: width < 640 ? width - 10 : width/2.85,
      content: Text(msg),
      behavior: SnackBarBehavior.floating,
      backgroundColor: snackBarColor,
    ),
  );
}
