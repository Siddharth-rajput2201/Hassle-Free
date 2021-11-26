import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Classes/Pass.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/utils/BottomModalSheetAddPass.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

class UserPass extends StatefulWidget {
  const UserPass({Key? key}) : super(key: key);

  @override
  _UserPassState createState() => _UserPassState();
}

class _UserPassState extends State<UserPass> {
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
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25))),
                context: context,
                builder: (context) {
                  
                  return BottomModalSheetAddPass();
                });
          },
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
                        physics: BouncingScrollPhysics(),
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
                              height: height * 0.25,
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
                                        FutureBuilder(
                                          future: Network.decrypt(
                                              passData[index].encryptedPassword,
                                              context),
                                          builder: (_, snapshot) {
                                            if (snapshot.hasData) {
                                              return Row(
                                                children: [
                                                  Text(
                                                    snapshot.data.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: height * 0.030,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: width * 0.025,
                                                  ),
                                                  InkWell(
                                                    onTap: () async {
                                                      ClipboardData data =
                                                          ClipboardData(
                                                              text: snapshot
                                                                  .data
                                                                  .toString());
                                                      await Clipboard.setData(
                                                          data);
                                                      customSnackBar(
                                                          context,
                                                          "COPIED TO CLIPBOARD",
                                                          Colors.green);
                                                    },
                                                    child: Icon(
                                                      Icons.copy_outlined,
                                                      color: Colors.white,
                                                    ),
                                                  )
                                                ],
                                              );
                                            } else {
                                              return Shimmer.fromColors(
                                                child: Center(
                                                  child: Text(
                                                    "PASSWORD",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: height * 0.030,
                                                    ),
                                                  ),
                                                ),
                                                baseColor: Colors.grey,
                                                highlightColor: Colors.white,
                                              );
                                            }
                                          },
                                        )
                                      ],
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.edit,
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
                      return Shimmer.fromColors(
                          child: Center(
                              child: Text(
                            "HASSLE FREE",
                            style: TextStyle(fontSize: height * 0.05),
                          )),
                          baseColor: Colors.grey,
                          highlightColor: Colors.white);
                    }
                  },
                ),
              ),
            ),
          ],
        ));
  }
}
