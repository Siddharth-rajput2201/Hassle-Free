import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Classes/Pass.dart';
import 'package:hassle_free/Networking/NetworkingWeb.dart';
import 'package:hassle_free/utils/BottomModalSheetAddPass.dart';
import 'package:hassle_free/utils/BottomModalSheetDelete.dart';
import 'package:hassle_free/utils/BottomModalSheetEdit.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/ThemeColors.dart';
import 'package:shimmer/shimmer.dart';

class UserPassWeb extends StatefulWidget {
  const UserPassWeb({Key? key}) : super(key: key);

  @override
  State<UserPassWeb> createState() => _UserPassWebState();
}

class _UserPassWebState extends State<UserPassWeb> {
  static int mobileLimit = 640;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constaints) {
        if (constaints.maxWidth <= mobileLimit) {
          return UserPassWebView(
              maxWidth: constaints.maxWidth, maxHeight: constaints.maxHeight);
        } else {
          return UserPassWebView(
            maxWidth: constaints.maxWidth / 2.85,
            maxHeight: constaints.maxHeight,
          );
        }
      },
    );
  }
}

class UserPassWebView extends StatefulWidget {
  const UserPassWebView(
      {required this.maxHeight, required this.maxWidth, Key? key})
      : super(key: key);
  final double maxWidth;
  final double maxHeight;
  @override
  State<UserPassWebView> createState() => _UserPassWebViewState();
}

class _UserPassWebViewState extends State<UserPassWebView> {
  List<Pass> passData = [];
  List<Pass> searchResult = [];
  TextEditingController searchController = TextEditingController();
  bool _isFabEnabled = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ThemeColors.kBackGroundColor,
      floatingActionButton: _isFabEnabled
          ? Container(
              decoration: BoxDecoration(
                color: ThemeColors.kBackGroundColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: ThemeColors.kDarkShadowColor,
                    offset: Offset(5, 5),
                    blurRadius: 7,
                    spreadRadius: 0.2,
                  ),
                  BoxShadow(
                    color: ThemeColors.kLightShadowColor,
                    offset: Offset(-5, -5),
                    blurRadius: 7,
                    spreadRadius: 0.2,
                  )
                ],
              ),
              child: FloatingActionButton(
                disabledElevation: 0,
                elevation: 0,
                backgroundColor: ThemeColors.kBackGroundColor,
                onPressed: () async {
                  await showModalBottomSheet(
                      backgroundColor: ThemeColors.kBackGroundColor,
                      isScrollControlled: true,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(25),
                              topRight: Radius.circular(25))),
                      context: context,
                      builder: (context) {
                        return BottomModalSheetAddPass();
                      });
                  setState(() {});
                },
                child: Icon(
                  Icons.add,
                  color: ThemeColors.kTextColor,
                ),
                // backgroundColor:
                //     Colors.primaries[Random().nextInt(Colors.primaries.length)],
              ),
            )
          : null,
      body: Column(
        children: [
          Expanded(
            child: Container(
              child: FutureBuilder(
                future: NetworkWeb.retrieve(context),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    passData = (snapshot.data as List<Pass>);
                    return NotificationListener<UserScrollNotification>(
                      onNotification: (notification) {
                        if (notification.direction == ScrollDirection.forward) {
                          if (!_isFabEnabled) {
                            setState(() {
                              _isFabEnabled = true;
                            });
                          }
                        } else if (notification.direction ==
                            ScrollDirection.reverse) {
                          if (_isFabEnabled) {
                            setState(() {
                              _isFabEnabled = false;
                            });
                          }
                        } else if (notification.direction ==
                            ScrollDirection.idle) {
                          if (!_isFabEnabled) {
                            setState(() {
                              _isFabEnabled = true;
                            });
                          }
                        }
                        return true;
                      },
                      child: width <= 640
                          ? Scrollbar(
                            child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: passData.length,
                                itemBuilder: (_, index) {
                                  // Color randomColor = Colors.primaries[
                                  //     Random().nextInt(Colors.primaries.length)];
                                  return Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ThemeColors.kBackGroundColor,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ThemeColors.kDarkShadowColor,
                                            offset: Offset(5, 5),
                                            blurRadius: 10,
                                            spreadRadius: 0.5,
                                          ),
                                          BoxShadow(
                                            color: ThemeColors.kLightShadowColor,
                                            offset: Offset(-5, -5),
                                            blurRadius: 10,
                                            spreadRadius: 0.5,
                                          )
                                        ],
                                      ),
                                      height: height * 0.30,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: width * 0.65,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      passData[index].appName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: ThemeColors
                                                            .kTextColor,
                                                        fontSize: height * 0.040,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          passData[index]
                                                              .username,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                            color: ThemeColors
                                                                .kTextColor,
                                                            fontSize:
                                                                height * 0.030,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 10.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ThemeColors
                                                                .kBackGroundColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(30),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: ThemeColors
                                                                    .kDarkShadowColor,
                                                                offset:
                                                                    Offset(5, 5),
                                                                blurRadius: 10,
                                                                spreadRadius: 0.5,
                                                              ),
                                                              BoxShadow(
                                                                color: ThemeColors
                                                                    .kLightShadowColor,
                                                                offset: Offset(
                                                                    -5, -5),
                                                                blurRadius: 10,
                                                                spreadRadius: 0.5,
                                                              )
                                                            ],
                                                          ),
                                                          child: Material(
                                                            type: MaterialType
                                                                .transparency,
                                                            child: IconButton(
                                                              splashRadius: 23,
                                                              onPressed:
                                                                  () async {
                                                                ClipboardData
                                                                    data =
                                                                    ClipboardData(
                                                                        text: passData[
                                                                                index]
                                                                            .username);
                                                                await Clipboard
                                                                    .setData(
                                                                        data);
                                                                customSnackBar(
                                                                    context,
                                                                    "COPIED TO CLIPBOARD",
                                                                    Colors.green);
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .copy_outlined,
                                                                color: ThemeColors
                                                                    .kTextColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.001),
                                                  FutureBuilder(
                                                    future: NetworkWeb.decrypt(
                                                        passData[index]
                                                            .encryptedPassword,
                                                        context),
                                                    builder: (_, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Row(
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                snapshot.data
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                                style: TextStyle(
                                                                  color: ThemeColors
                                                                      .kTextColor,
                                                                  fontSize:
                                                                      height *
                                                                          0.030,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ThemeColors
                                                                      .kBackGroundColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: ThemeColors
                                                                          .kDarkShadowColor,
                                                                      offset:
                                                                          Offset(
                                                                              5,
                                                                              5),
                                                                      blurRadius:
                                                                          10,
                                                                      spreadRadius:
                                                                          0.5,
                                                                    ),
                                                                    BoxShadow(
                                                                      color: ThemeColors
                                                                          .kLightShadowColor,
                                                                      offset:
                                                                          Offset(
                                                                              -5,
                                                                              -5),
                                                                      blurRadius:
                                                                          10,
                                                                      spreadRadius:
                                                                          0.5,
                                                                    )
                                                                  ],
                                                                ),
                                                                child: Material(
                                                                  type: MaterialType
                                                                      .transparency,
                                                                  child:
                                                                      IconButton(
                                                                    splashRadius:
                                                                        23,
                                                                    onPressed:
                                                                        () async {
                                                                      ClipboardData
                                                                          data =
                                                                          ClipboardData(
                                                                              text:
                                                                                  snapshot.data.toString());
                                                                      await Clipboard
                                                                          .setData(
                                                                              data);
                                                                      customSnackBar(
                                                                          context,
                                                                          "COPIED TO CLIPBOARD",
                                                                          Colors
                                                                              .green);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .copy_outlined,
                                                                      color: ThemeColors
                                                                          .kTextColor,
                                                                    ),
                                                                  ),
                                                                ),
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
                                                                color: ThemeColors
                                                                    .kTextColor,
                                                                fontSize: height *
                                                                    0.030,
                                                              ),
                                                            ),
                                                          ),
                                                          baseColor: Colors.grey,
                                                          highlightColor:
                                                              Colors.white,
                                                        );
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: ThemeColors
                                                          .kBackGroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: ThemeColors
                                                              .kDarkShadowColor,
                                                          offset: Offset(5, 5),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        ),
                                                        BoxShadow(
                                                          color: ThemeColors
                                                              .kLightShadowColor,
                                                          offset: Offset(-5, -5),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        )
                                                      ],
                                                    ),
                                                    child: Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  ThemeColors
                                                                      .kBackGroundColor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              25),
                                                                      topRight: Radius
                                                                          .circular(
                                                                              25))),
                                                              context: context,
                                                              builder: (builder) {
                                                                return BottomModalSheetEdit(
                                                                    appname: passData[
                                                                            index]
                                                                        .appName,
                                                                    passwordId: passData[
                                                                            index]
                                                                        .passwordId
                                                                        .toString());
                                                              });
                                                          setState(() {});
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: ThemeColors
                                                                .kTextColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: ThemeColors
                                                          .kBackGroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: ThemeColors
                                                              .kDarkShadowColor,
                                                          offset: Offset(5, 5),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        ),
                                                        BoxShadow(
                                                          color: ThemeColors
                                                              .kLightShadowColor,
                                                          offset: Offset(-5, -5),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        )
                                                      ],
                                                    ),
                                                    child: Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                              backgroundColor:
                                                                  ThemeColors
                                                                      .kBackGroundColor,
                                                              isScrollControlled:
                                                                  true,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              25),
                                                                      topRight: Radius
                                                                          .circular(
                                                                              25))),
                                                              context: context,
                                                              builder: (context) {
                                                                return BottomModalSheetDelete(
                                                                  appName: passData[
                                                                          index]
                                                                      .appName,
                                                                  passwordId: passData[
                                                                          index]
                                                                      .passwordId
                                                                      .toString(),
                                                                );
                                                              });
                                                          setState(() {});
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Icon(
                                                            Icons.delete_outline,
                                                            color: ThemeColors
                                                                .kTextColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                          )
                          : Scrollbar(
                            child: GridView.builder(
                                physics: BouncingScrollPhysics(),
                                itemCount: passData.length,
                                gridDelegate:
                                    SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: 350),
                                itemBuilder: (_, index) {
                                  // Color randomColor = Colors.primaries[
                                  //     Random().nextInt(Colors.primaries.length)];
                                  return Padding(
                                    padding: const EdgeInsets.all(18.0),
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: ThemeColors.kBackGroundColor,
                                        borderRadius: BorderRadius.circular(30),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ThemeColors.kDarkShadowColor,
                                            offset: Offset(5, 5),
                                            blurRadius: 10,
                                            spreadRadius: 0.5,
                                          ),
                                          BoxShadow(
                                            color: ThemeColors.kLightShadowColor,
                                            offset: Offset(-5, -5),
                                            blurRadius: 10,
                                            spreadRadius: 0.5,
                                          )
                                        ],
                                      ),
                                      height: height * 0.30,
                                      child: Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: widget.maxWidth * 0.35,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Flexible(
                                                    child: Text(
                                                      passData[index].appName,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                        color: ThemeColors
                                                            .kTextColor,
                                                        fontSize: height * 0.040,
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: height * 0.01,
                                                  ),
                                                  Row(
                                                    children: [
                                                      Flexible(
                                                        child: Text(
                                                          passData[index]
                                                              .username,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          softWrap: false,
                                                          style: TextStyle(
                                                            color: ThemeColors
                                                                .kTextColor,
                                                            fontSize:
                                                                height * 0.030,
                                                          ),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets.only(
                                                                left: 10.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            color: ThemeColors
                                                                .kBackGroundColor,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(30),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                color: ThemeColors
                                                                    .kDarkShadowColor,
                                                                offset:
                                                                    Offset(5, 5),
                                                                blurRadius: 10,
                                                                spreadRadius: 0.5,
                                                              ),
                                                              BoxShadow(
                                                                color: ThemeColors
                                                                    .kLightShadowColor,
                                                                offset: Offset(
                                                                    -5, -5),
                                                                blurRadius: 10,
                                                                spreadRadius: 0.5,
                                                              )
                                                            ],
                                                          ),
                                                          child: Material(
                                                            type: MaterialType
                                                                .transparency,
                                                            child: IconButton(
                                                              splashRadius: 23,
                                                              onPressed:
                                                                  () async {
                                                                ClipboardData
                                                                    data =
                                                                    ClipboardData(
                                                                        text: passData[
                                                                                index]
                                                                            .username);
                                                                await Clipboard
                                                                    .setData(
                                                                        data);
                                                                customSnackBar(
                                                                    context,
                                                                    "COPIED TO CLIPBOARD",
                                                                    Colors.green);
                                                              },
                                                              icon: Icon(
                                                                Icons
                                                                    .copy_outlined,
                                                                color: ThemeColors
                                                                    .kTextColor,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  SizedBox(
                                                      height: height * 0.001),
                                                  FutureBuilder(
                                                    future: NetworkWeb.decrypt(
                                                        passData[index]
                                                            .encryptedPassword,
                                                        context),
                                                    builder: (_, snapshot) {
                                                      if (snapshot.hasData) {
                                                        return Row(
                                                          children: [
                                                            Flexible(
                                                              child: Text(
                                                                snapshot.data
                                                                    .toString(),
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis,
                                                                softWrap: false,
                                                                style: TextStyle(
                                                                  color: ThemeColors
                                                                      .kTextColor,
                                                                  fontSize:
                                                                      height *
                                                                          0.030,
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left: 10.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  color: ThemeColors
                                                                      .kBackGroundColor,
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                      color: ThemeColors
                                                                          .kDarkShadowColor,
                                                                      offset:
                                                                          Offset(
                                                                              5,
                                                                              5),
                                                                      blurRadius:
                                                                          10,
                                                                      spreadRadius:
                                                                          0.5,
                                                                    ),
                                                                    BoxShadow(
                                                                      color: ThemeColors
                                                                          .kLightShadowColor,
                                                                      offset:
                                                                          Offset(
                                                                              -5,
                                                                              -5),
                                                                      blurRadius:
                                                                          10,
                                                                      spreadRadius:
                                                                          0.5,
                                                                    )
                                                                  ],
                                                                ),
                                                                child: Material(
                                                                  type: MaterialType
                                                                      .transparency,
                                                                  child:
                                                                      IconButton(
                                                                    splashRadius:
                                                                        23,
                                                                    onPressed:
                                                                        () async {
                                                                      ClipboardData
                                                                          data =
                                                                          ClipboardData(
                                                                              text:
                                                                                  snapshot.data.toString());
                                                                      await Clipboard
                                                                          .setData(
                                                                              data);
                                                                      customSnackBar(
                                                                          context,
                                                                          "COPIED TO CLIPBOARD",
                                                                          Colors
                                                                              .green);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons
                                                                          .copy_outlined,
                                                                      color: ThemeColors
                                                                          .kTextColor,
                                                                    ),
                                                                  ),
                                                                ),
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
                                                                color: ThemeColors
                                                                    .kTextColor,
                                                                fontSize: height *
                                                                    0.030,
                                                              ),
                                                            ),
                                                          ),
                                                          baseColor: Colors.grey,
                                                          highlightColor:
                                                              Colors.white,
                                                        );
                                                      }
                                                    },
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: ThemeColors
                                                          .kBackGroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: ThemeColors
                                                              .kDarkShadowColor,
                                                          offset: Offset(5, 5),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        ),
                                                        BoxShadow(
                                                          color: ThemeColors
                                                              .kLightShadowColor,
                                                          offset: Offset(-5, -5),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        )
                                                      ],
                                                    ),
                                                    child: Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                              isScrollControlled:
                                                                  true,
                                                              backgroundColor:
                                                                  ThemeColors
                                                                      .kBackGroundColor,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              25),
                                                                      topRight: Radius
                                                                          .circular(
                                                                              25))),
                                                              context: context,
                                                              builder: (builder) {
                                                                return BottomModalSheetEdit(
                                                                    appname: passData[
                                                                            index]
                                                                        .appName,
                                                                    passwordId: passData[
                                                                            index]
                                                                        .passwordId
                                                                        .toString());
                                                              });
                                                          setState(() {});
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Icon(
                                                            Icons.edit,
                                                            color: ThemeColors
                                                                .kTextColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    decoration: BoxDecoration(
                                                      color: ThemeColors
                                                          .kBackGroundColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30),
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: ThemeColors
                                                              .kDarkShadowColor,
                                                          offset: Offset(5, 5),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        ),
                                                        BoxShadow(
                                                          color: ThemeColors
                                                              .kLightShadowColor,
                                                          offset: Offset(-5, -5),
                                                          blurRadius: 10,
                                                          spreadRadius: 1,
                                                        )
                                                      ],
                                                    ),
                                                    child: Material(
                                                      type: MaterialType
                                                          .transparency,
                                                      child: InkWell(
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    50)),
                                                        onTap: () async {
                                                          await showModalBottomSheet(
                                                              backgroundColor:
                                                                  ThemeColors
                                                                      .kBackGroundColor,
                                                              isScrollControlled:
                                                                  true,
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius: BorderRadius.only(
                                                                      topLeft: Radius
                                                                          .circular(
                                                                              25),
                                                                      topRight: Radius
                                                                          .circular(
                                                                              25))),
                                                              context: context,
                                                              builder: (context) {
                                                                return BottomModalSheetDelete(
                                                                  appName: passData[
                                                                          index]
                                                                      .appName,
                                                                  passwordId: passData[
                                                                          index]
                                                                      .passwordId
                                                                      .toString(),
                                                                );
                                                              });
                                                          setState(() {});
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(15.0),
                                                          child: Icon(
                                                            Icons.delete_outline,
                                                            color: ThemeColors
                                                                .kTextColor,
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },),
                          ),
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
      ),
    );
  }
}
