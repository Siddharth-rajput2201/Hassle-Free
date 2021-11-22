import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Classes/Pass.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/BottomModalSheet.dart';
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
    Colors.yellow[700],
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add),
          backgroundColor:
              Colors.primaries[Random().nextInt(Colors.primaries.length)],
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
                            padding: const EdgeInsets.all(18.0),
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
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Text(
                                          passData[index].appName,
                                          style: TextStyle(
                                            color: Colors.white,
                                            fontSize: height * 0.040,
                                          ),
                                        ),
                                        Row(
                                          children: [
                                            Text(
                                              passData[index].username,
                                              style: TextStyle(
                                                color: Colors.white,
                                                fontSize: height * 0.030,
                                              ),
                                            ),
                                            IconButton(
                                              onPressed: () async {
                                                ClipboardData data =
                                                    ClipboardData(
                                                        text: passData[index]
                                                            .username);
                                                await Clipboard.setData(data);
                                                customSnackBar(
                                                    context,
                                                    "COPIED TO CLIPBOARD",
                                                    Colors.green);
                                              },
                                              icon: Icon(
                                                Icons.copy_outlined,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor: randomColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  25)),
                                                ),
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox(
                                                    height: height * 0.25,
                                                    child: SizedBox(
                                                      child: FutureBuilder(
                                                        future: Network.decrypt(
                                                            passData[index]
                                                                .encryptedPassword,
                                                            context),
                                                        builder: (_, snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return SizedBox(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    passData[
                                                                            index]
                                                                        .username,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          height *
                                                                              0.040,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot
                                                                        .data
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          height *
                                                                              0.040,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          } else {
                                                            return Column(
                                                              children: [
                                                                CircularProgressIndicator()
                                                              ],
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.white,
                                          ),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            showModalBottomSheet(
                                                backgroundColor: randomColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  25),
                                                          topRight:
                                                              Radius.circular(
                                                                  25)),
                                                ),
                                                context: context,
                                                builder: (context) {
                                                  return SizedBox(
                                                    height: height * 0.25,
                                                    child: SizedBox(
                                                      child: FutureBuilder(
                                                        future: Network.decrypt(
                                                            passData[index]
                                                                .encryptedPassword,
                                                            context),
                                                        builder: (_, snapshot) {
                                                          if (snapshot
                                                              .hasData) {
                                                            return SizedBox(
                                                              child: Column(
                                                                children: [
                                                                  Text(
                                                                    passData[
                                                                            index]
                                                                        .username,
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          height *
                                                                              0.040,
                                                                    ),
                                                                  ),
                                                                  Text(
                                                                    snapshot
                                                                        .data
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontSize:
                                                                          height *
                                                                              0.040,
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            );
                                                          } else {
                                                            return Column(
                                                              children: [
                                                                CircularProgressIndicator()
                                                              ],
                                                            );
                                                          }
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                });
                                          },
                                          icon: Icon(
                                            Icons.lock_outline,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
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
