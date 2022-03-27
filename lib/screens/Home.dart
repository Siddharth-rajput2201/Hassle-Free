import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:flutter/rendering.dart';
// import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Classes/Pass.dart';
// import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/GenPass.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/screens/UserPass.dart';
import 'package:hassle_free/utils/BottomModalSheetAddPass.dart';
// import 'package:hassle_free/utils/BottomModalSheetDelete.dart';
// import 'package:hassle_free/utils/BottomModalSheetEdit.dart';
// import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/ThemeColors.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Pass> passData = [];
  List<Pass> searchResult = [];
  List<IconData> listOfIcons = [
    Icons.home_rounded,
    Icons.lock_rounded
  ];

  List<String> listOfStrings = [
    'Home',
    'Password',
  ];
  TextEditingController searchController = TextEditingController();
  bool _isFabEnabled = true;
  int currentIndex = 0;
  final screens = [UserPass(), GenPass()];
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      drawer: Drawer(backgroundColor: ThemeColors.kBackGroundColor),
      backgroundColor: ThemeColors.kBackGroundColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15.0),
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
          padding: EdgeInsets.symmetric(horizontal: width * .02),
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
                  width: index == currentIndex
                      ? width * .48
                      : width * .12,
                  alignment: Alignment.center,
                  child: AnimatedContainer(
                    duration: Duration(seconds: 1),
                    curve: Curves.fastLinearToSlowEaseIn,
                    height: index == currentIndex ? width * .12 : 0,
                    width: index == currentIndex ? width * .45 : 12,
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
                  width: index == currentIndex
                      ? width * .40
                      : width * .40,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Row(
                        children: [
                          AnimatedContainer(
                            duration: Duration(seconds: 1),
                            curve: Curves.fastLinearToSlowEaseIn,
                            width:
                                index == currentIndex ? width * .20 : 0,
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
                                index == currentIndex ? width * .09 : 60,
                          ),
                          Icon(
                            listOfIcons[index],
                            size: width * .076,
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
        actions: [
          Padding(
            padding: const EdgeInsets.all(8),
            child: GestureDetector(
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                await prefs.clear();
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Login()),
                );
              },
              child: Container(
                width: width * 0.135,
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
                  Icons.logout,
                  color: ThemeColors.kTextColor,
                ),
              ),
            ),
          )
        ],
        backgroundColor: ThemeColors.kBackGroundColor,
        title: Center(
          child: Text(
            "Hassle Free",
            style: TextStyle(
                color: ThemeColors.kTextColor, fontWeight: FontWeight.w600),
          ),
        ),
      ),
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
      body: IndexedStack(index: currentIndex, children: screens),
    );
  }
}
