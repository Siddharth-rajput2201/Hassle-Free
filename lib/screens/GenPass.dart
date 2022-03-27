import 'package:flutter/material.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class GenPass extends StatefulWidget {
  const GenPass({ Key? key }) : super(key: key);

  @override
  State<GenPass> createState() => _GenPassState();
}

class _GenPassState extends State<GenPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kBackGroundColor,
    );
  }
}