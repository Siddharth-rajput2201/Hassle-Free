import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Classes/Pass.dart';
import 'package:hassle_free/screens/DeleteAccount.dart';
import 'package:hassle_free/screensweb/GenPassWeb.dart';
import 'package:hassle_free/screensweb/LoginWeb.dart';
import 'package:hassle_free/screensweb/UserPassWeb.dart';
import 'package:hassle_free/utils/Storage.dart';
import 'package:hassle_free/utils/ThemeColors.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeWeb extends StatefulWidget {
  const HomeWeb({Key? key}) : super(key: key);

  @override
  State<HomeWeb> createState() => _HomeWebState();
}

class _HomeWebState extends State<HomeWeb> {
  static int mobileLimit = 640;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constaints) {
        if (constaints.maxWidth <= mobileLimit) {
          return HomeWebView(
              maxWidth: constaints.maxWidth, maxHeight: constaints.maxHeight);
        } else {
          return HomeWebView(
            maxWidth: constaints.maxWidth / 2.85,
            maxHeight: constaints.maxHeight,
          );
        }
      },
    );
  }
}

class HomeWebView extends StatefulWidget {
  const HomeWebView({required this.maxHeight, required this.maxWidth, Key? key})
      : super(key: key);
  final double maxWidth;
  final double maxHeight;
  @override
  State<HomeWebView> createState() => _HomeWebViewState();
}

class _HomeWebViewState extends State<HomeWebView> {
  List<Pass> passData = [];
  List<Pass> searchResult = [];
  List<IconData> listOfIcons = [Icons.home_rounded, Icons.lock_rounded];

  List<String> listOfStrings = [
    'Home',
    'Password',
  ];
  TextEditingController searchController = TextEditingController();
  int currentIndex = 0;
  final screens = [UserPassWeb(), GenPassWeb()];
  @override
  Widget build(BuildContext context) {
    {
      double width = MediaQuery.of(context).size.width;
      double height = MediaQuery.of(context).size.height;
      return Scaffold(
          drawer: Drawer(
            backgroundColor: ThemeColors.kBackGroundColor,
            child: ListView(
              children: [
                SizedBox(
                  height: height * 0.1,
                  child: FutureBuilder<Object>(
                      future: Storage.getUserName(),
                      builder: (context, snapshot) {
                        return Center(
                          child: Text(
                            snapshot.data.toString(),
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: height * 0.035),
                          ),
                        );
                      }),
                ),
                ListTile(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DeleteAccount()),
                    );
                  },
                  leading: Icon(
                    Icons.delete_forever,
                    color: ThemeColors.kDeleteColor,
                  ),
                  title: Text(
                    "Delete Account",
                    style: TextStyle(
                        color: ThemeColors.kDeleteColor,
                        fontSize: height * 0.025),
                  ),
                ),
                ListTile(
                  onTap: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.clear();
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginWeb()),
                    );
                  },
                  leading: Icon(
                    Icons.logout,
                  ),
                  title: Text(
                    "Logout",
                    style: TextStyle(fontSize: height * 0.025),
                  ),
                ),
              ],
            ),
          ),
          backgroundColor: ThemeColors.kBackGroundColor,
          bottomNavigationBar: Padding(
            padding: EdgeInsets.only(left : width <= 640 ? 15 : widget.maxWidth * 0.97,right: width <= 640 ? 15 : widget.maxWidth * 0.97 , bottom: 15 , top : 15),
            child: Container(
              height: height * .1,
              decoration: BoxDecoration(
                  color: ThemeColors.kBackGroundColor,
                  borderRadius: BorderRadius.circular(50),
                  gradient: LinearGradient(
                    colors: [
                      ThemeColors.kLinearFirstGradient,
                      ThemeColors.kLinearSecondGradient,
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 0.4],
                    tileMode: TileMode.clamp,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: ThemeColors.kDarkShadowColor,
                      offset: Offset(5, 5),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                    BoxShadow(
                      color: ThemeColors.kLightShadowColor,
                      offset: Offset(-5, -5),
                      blurRadius: 15,
                      spreadRadius: 1,
                    )
                  ]),
              child: ListView.builder(
                itemCount: 2,
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: widget.maxWidth * .02),
                itemBuilder: (context, index) => InkWell(
                  onTap: () {
                    setState(() {
                      currentIndex = index;
                      HapticFeedback.lightImpact();
                    });
                  },
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  child: Stack(
                    children: [
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width:
                            index == currentIndex ? widget.maxWidth * .48 : widget.maxWidth * .12,
                        alignment: Alignment.center,
                        child: AnimatedContainer(
                          duration: Duration(seconds: 1),
                          curve: Curves.fastLinearToSlowEaseIn,
                          height: index == currentIndex ? widget.maxWidth * .12 : 0,
                          width: index == currentIndex ? widget.maxWidth * .45 : 12,
                          decoration: BoxDecoration(
                            color: index == currentIndex
                                ? Colors.blueAccent.withOpacity(.2)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                      ),
                      AnimatedContainer(
                        duration: Duration(seconds: 1),
                        curve: Curves.fastLinearToSlowEaseIn,
                        width:
                            index == currentIndex ? widget.maxWidth * .40 : widget.maxWidth * .40,
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width:
                                      index == currentIndex ? widget.maxWidth * .20 : 0,
                                ),
                                AnimatedOpacity(
                                  opacity: index == currentIndex ? 1 : 0,
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  child: Text(
                                    '${listOfStrings[index]}',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(seconds: 1),
                                  curve: Curves.fastLinearToSlowEaseIn,
                                  width:
                                      index == currentIndex ? widget.maxWidth * .09 : 60,
                                ),
                                Icon(
                                  listOfIcons[index],
                                  size: widget.maxWidth * .076,
                                  color: index == currentIndex
                                      ? Colors.blueAccent
                                      : Colors.black26,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          appBar: AppBar(
            centerTitle: true,
            toolbarHeight: height * 0.125,
            elevation: 0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Builder(builder: (context) {
                return GestureDetector(
                  onTap: () {
                    Scaffold.of(context).openDrawer();
                  },
                  child: Container(
                    width: width * 0.125,
                    decoration: BoxDecoration(
                        color: ThemeColors.kBackGroundColor,
                        shape: BoxShape.circle,
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
                        ]),
                    child: Icon(
                      Icons.menu,
                      color: ThemeColors.kTextColor,
                    ),
                  ),
                );
              }),
            ),
            // actions: [
            //   Padding(
            //     padding: const EdgeInsets.all(8),
            //     child: GestureDetector(
            //       onTap: () async {
            //         SharedPreferences prefs =
            //             await SharedPreferences.getInstance();
            //         await prefs.clear();
            //         Navigator.pushReplacement(
            //           context,
            //           MaterialPageRoute(builder: (context) => Login()),
            //         );
            //       },
            //       child: Container(
            //         width: width * 0.135,
            //         decoration: BoxDecoration(
            //             color: ThemeColors.kBackGroundColor,
            //             shape: BoxShape.circle,
            //             boxShadow: [
            //               BoxShadow(
            //                 color: ThemeColors.kDarkShadowColor,
            //                 offset: Offset(5, 5),
            //                 blurRadius: 7,
            //                 spreadRadius: 0.2,
            //               ),
            //               BoxShadow(
            //                 color: ThemeColors.kLightShadowColor,
            //                 offset: Offset(-5, -5),
            //                 blurRadius: 7,
            //                 spreadRadius: 0.2,
            //               )
            //             ]),
            //         child: Icon(
            //           Icons.logout,
            //           color: ThemeColors.kTextColor,
            //         ),
            //       ),
            //     ),
            //   )
            // ],
            backgroundColor: ThemeColors.kBackGroundColor,
            title: Text(
              "Hassle Free",
              style: TextStyle(
                  color: ThemeColors.kTextColor, fontWeight: FontWeight.w600),
            ),
          ),
          body: IndexedStack(
            children: screens,
            index: currentIndex,
          ));
    }
  }
}
