import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Classes/Pass.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPass extends StatefulWidget {
  const UserPass({Key? key}) : super(key: key);

  @override
  _UserPassState createState() => _UserPassState();
}

class _UserPassState extends State<UserPass> {
  var colors = [
    Colors.red,
    Colors.blue,
    Colors.cyan,
    Colors.green,
    Colors.yellow,
  ];
  List<Pass> passData = [];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              icon: Icon(Icons.logout),
              color: Colors.black,
            )
          ],
          backgroundColor: Colors.white,
          title: Text(
            "Hassle Free",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Container(
                child: FutureBuilder(
                  future: Network.retrieve(context),
                  builder: (_, snapshot) {
                    if (snapshot.hasData) {
                      passData = (snapshot.data as List<Pass>);
                      return ListView.builder(
                        itemCount: passData.length,
                        itemBuilder: (_, index) {
                          Color randomColor = Colors.primaries[
                              Random().nextInt(Colors.primaries.length)];
                          return Padding(
                            padding: const EdgeInsets.all(25.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: randomColor,
                                borderRadius: BorderRadius.circular(25),
                                boxShadow: [
                                  BoxShadow(
                                    color: randomColor,
                                    blurRadius: 20,
                                  )
                                ],
                              ),
                              height: height * 0.2,
                              width: width * 0.4,
                              child: Column(
                                children: [
                                  Text(
                                    passData[index].appName,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: height * 0.05,
                                    ),
                                  ),
                                  Text(passData[index].username),
                                  Text(passData[index].passwordId.toString()),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return Text("SADASDASSD");
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
