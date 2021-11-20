import 'package:flutter/material.dart';

class UserPass extends StatefulWidget {
  const UserPass({Key? key}) : super(key: key);

  @override
  _UserPassState createState() => _UserPassState();
}

class _UserPassState extends State<UserPass> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("App Pass"),
      ),
    );
  }
}
