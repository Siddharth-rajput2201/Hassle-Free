import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class DialogBoxAddPass extends StatefulWidget {
  const DialogBoxAddPass({Key? key}) : super(key: key);

  @override
  State<DialogBoxAddPass> createState() => _DialogBoxAddPassState();
}

class _DialogBoxAddPassState extends State<DialogBoxAddPass> {
  TextEditingController appNameController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _appnameEnabled = true;
  bool _usernameEnabled = true;
  bool _passwordEnabled = true;
  bool _addButtonEnabled = true;
  bool _showPasswordEnabled = true;
  final formGlobalKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    Future _validateAddPass() async {
      if (formGlobalKey.currentState!.validate() == true) {
        await Network.addpass(
                userNameController.text.trim(),
                passwordController.text.trim(),
                appNameController.text.trim(),
                context)
            .whenComplete(() {
          Navigator.pop(context);
        });
      }
    }

    return SingleChildScrollView(
      child: Form(
        key: formGlobalKey,
        child: Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: SizedBox(
            height: height * 0.75,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Material(
                      borderRadius: BorderRadius.circular(30),
                            color: ThemeColors.kBackGroundColor,
                    child: InkWell(
                       highlightColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              onTap: (){
                                Navigator.pop(context);
                              },
                      child: Icon(Icons.close_rounded),
                    ),
                  ),
                  Container(
                    width: width * 0.4,
                    height: height * 0.5,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: ThemeColors.kBackGroundColor,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                            color: ThemeColors.kDarkShadowColor,
                            offset: Offset(5, 5),
                            blurRadius: 10,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: ThemeColors.kLightShadowColor,
                            offset: Offset(-5, -5),
                            blurRadius: 10,
                            spreadRadius: 1,
                          )
                        ]),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Center(
                          child: Text(
                            "ADD PASSWORD",
                            style: TextStyle(
                                fontSize: height * 0.05,
                                fontWeight: FontWeight.w900,
                                color: Color(0xFF747474)),
                          ),
                        ),
                        Container(
                          decoration: ShapeDecoration(
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
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),
                          child: TextFormField(
                            enabled: _appnameEnabled,
                            controller: appNameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ThemeColors.kBackGroundColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ThemeColors.kBackGroundColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              prefixIcon: Icon(Icons.android_outlined),
                              hintText: "APP NAME",
                              hintStyle: TextStyle(fontSize: height * 0.025),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (valUsername) {
                              if (valUsername!.isEmpty) {
                                return "APP NAME CANNOT BE EMPTY";
                              } else {
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          decoration: ShapeDecoration(
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
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),
                          child: TextFormField(
                            enabled: _usernameEnabled,
                            controller: userNameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ThemeColors.kBackGroundColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ThemeColors.kBackGroundColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              prefixIcon: Icon(Icons.person_outline_outlined),
                              hintText: "USERNAME",
                              hintStyle: TextStyle(fontSize: height * 0.025),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            validator: (valUsername) {
                              if (valUsername!.isEmpty) {
                                return "USERNAME CANNOT BE EMPTY";
                              } else {
                                // setState(() {
                                //   _loginButtonEnabled = true;
                                // });
                                return null;
                              }
                            },
                          ),
                        ),
                        Container(
                          decoration: ShapeDecoration(
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
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),
                          child: TextFormField(
                            enabled: _passwordEnabled,
                            controller: passwordController,
                            obscureText: _showPasswordEnabled,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ThemeColors.kBackGroundColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: ThemeColors.kBackGroundColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              hintText: "PASSWORD",
                              hintStyle: TextStyle(fontSize: height * 0.025),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: InkWell(
                                child: Icon(_showPasswordEnabled
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                                onTap: () {
                                  setState(() {
                                    if (_showPasswordEnabled == true) {
                                      _showPasswordEnabled = false;
                                    } else {
                                      _showPasswordEnabled = true;
                                    }
                                  });
                                },
                              ),
                            ),
                            validator: (valPassword) {
                              if (valPassword!.isEmpty) {
                                return "PASSWORD CANNOT BE EMPTY";
                              } else {
                                // setState(() {
                                //   _loginButtonEnabled = true;
                                // });
                                return null;
                              }
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  _addButtonEnabled
                      ? Container(
                          // duration: Duration(milliseconds: 500),
                          height: height * 0.085,
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            color: ThemeColors.kBackGroundColor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                color: ThemeColors.kDarkShadowColor,
                                offset: Offset(4, 4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: ThemeColors.kLightShadowColor,
                                offset: Offset(-4, -4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Material(
                            borderRadius: BorderRadius.circular(30),
                            color: ThemeColors.kBackGroundColor,
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  _appnameEnabled = false;
                                  _usernameEnabled = false;
                                  _passwordEnabled = false;
                                  _addButtonEnabled = false;
                                });
                                await _validateAddPass();
                                setState(() {
                                  _appnameEnabled = true;
                                  _usernameEnabled = true;
                                  _passwordEnabled = true;
                                  _addButtonEnabled = true;
                                });
                              },
                              highlightColor: Colors.transparent,
                              borderRadius: BorderRadius.circular(30),
                              child: Center(
                                  child: Text(
                                "ADD",
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: height * 0.025,
                                    color: ThemeColors.kTextColor),
                              )),
                            ),
                          ),
                        )
                      : Container(
                          // duration: Duration(milliseconds: 500),
                          height: height * 0.085,
                          width: width * 0.4,
                          decoration: BoxDecoration(
                            color: ThemeColors.kBackGroundColor,
                            borderRadius: BorderRadius.circular(30),
                            gradient: LinearGradient(
                              colors: [
                                ThemeColors.kLinearFirstGradient,
                                ThemeColors.kLinearSecondGradient,
                                // Color(0xFFf7f5ec)
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              stops: [0.0, 0.4],
                              tileMode: TileMode.clamp,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: ThemeColors.kDarkShadowColor,
                                offset: Offset(4, 4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              ),
                              BoxShadow(
                                color: ThemeColors.kLightShadowColor,
                                offset: Offset(-4, -4),
                                blurRadius: 15,
                                spreadRadius: 1,
                              )
                            ],
                          ),
                          child: Center(
                            child: Text(
                              "ADD",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: height * 0.025,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
