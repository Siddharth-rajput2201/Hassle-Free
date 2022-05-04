import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/NetworkingWeb.dart';
import 'package:hassle_free/screensweb/RegisterWeb.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class LoginWeb extends StatefulWidget {
  const LoginWeb({Key? key}) : super(key: key);

  @override
  State<LoginWeb> createState() => _LoginWebState();
}

class _LoginWebState extends State<LoginWeb> {
  static int mobileLimit = 640;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constaints) {
        if (constaints.maxWidth <= mobileLimit) {
          return LoginWebView(
              maxWidth: constaints.maxWidth, maxHeight: constaints.maxHeight);
        } else {
          return LoginWebView(
            maxWidth: constaints.maxWidth / 2.85,
            maxHeight: constaints.maxHeight,
          );
        }
      },
    );
  }
}

class LoginWebView extends StatefulWidget {
  const LoginWebView(
      {required this.maxHeight, required this.maxWidth, Key? key})
      : super(key: key);
  final double maxWidth;
  final double maxHeight;
  @override
  State<LoginWebView> createState() => _LoginWebViewState();
}

class _LoginWebViewState extends State<LoginWebView> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _usernameEnabled = true;
  bool _passwordEnabled = true;
  bool _signUpButtonEnabled = true;
  bool _showPasswordEnabled = true;
  final formGlobalKey = GlobalKey<FormState>();

  void _redirect() async {
    await NetworkWeb.authweb(context);
  }

  Future _validatelogin() async {
    if (formGlobalKey.currentState!.validate() == true) {
      if (await NetworkWeb.login(userNameController.text.trim(),
          passwordController.text.trim(), context)) {
        _redirect();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    // double height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: ThemeColors.kBackGroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formGlobalKey,
                child: SizedBox(
                  height: widget.maxHeight * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: widget.maxHeight * 0.525,
                        width: width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Container(
                              // color: Colors.pink[300],
                              padding: EdgeInsets.only(
                                left: 10,
                                right: 10,
                                bottom: 7,
                              ),
                              height: widget.maxHeight * 0.35,
                              width: widget.maxWidth,
                              decoration: BoxDecoration(
                                  color: ThemeColors.kBackGroundColor,
                                  borderRadius: BorderRadius.circular(30),
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
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Center(
                                    child: Text(
                                      "Login",
                                      style: TextStyle(
                                          fontSize: widget.maxHeight * 0.05,
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)),
                                      ),
                                    ),
                                    child: TextFormField(
                                      enabled: _usernameEnabled,
                                      controller: userNameController,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ThemeColors.kBackGroundColor),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ThemeColors.kBackGroundColor),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        prefixIcon:
                                            Icon(Icons.person_outline_outlined),
                                        hintText: "USERNAME",
                                        hintStyle: TextStyle(
                                            fontSize: widget.maxHeight * 0.025),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
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
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(25.0)),
                                      ),
                                    ),
                                    child: TextFormField(
                                      enabled: _passwordEnabled,
                                      controller: passwordController,
                                      obscureText: _showPasswordEnabled,
                                      decoration: InputDecoration(
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ThemeColors.kBackGroundColor),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ThemeColors.kBackGroundColor),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        hintText: "PASSWORD",
                                        hintStyle: TextStyle(
                                            fontSize: widget.maxHeight * 0.025),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        prefixIcon: Icon(Icons.lock),
                                        suffixIcon: InkWell(
                                          child: Icon(_showPasswordEnabled
                                              ? Icons.visibility
                                              : Icons.visibility_off),
                                          onTap: () {
                                            setState(() {
                                              if (_showPasswordEnabled ==
                                                  true) {
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
                                          return null;
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            _signUpButtonEnabled
                                ? Container(
                                    // duration: Duration(milliseconds: 500),
                                    height: widget.maxHeight * 0.085,
                                    width: widget.maxWidth,
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
                                        highlightColor: Colors.transparent,
                                        borderRadius: BorderRadius.circular(30),
                                        onTap: () async {
                                          setState(() {
                                            _usernameEnabled = false;
                                            _passwordEnabled = false;
                                            _signUpButtonEnabled = false;
                                          });
                                          await _validatelogin();
                                          setState(() {
                                            _usernameEnabled = true;
                                            _passwordEnabled = true;
                                            _signUpButtonEnabled = true;
                                          });
                                        },
                                        child: Center(
                                            child: Text(
                                          "LOGIN",
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  widget.maxHeight * 0.025,
                                              color: ThemeColors.kTextColor),
                                        )),
                                      ),
                                    ),
                                  )
                                : Container(
                                    // duration: Duration(milliseconds: 500),
                                    height: widget.maxHeight * 0.085,
                                    width: widget.maxWidth,
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
                                        "LOGIN",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: widget.maxHeight * 0.025,
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ),
                                  ),
                          ],
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "NOT REGISTERED ?",
                                style:
                                    TextStyle(color: ThemeColors.kTextColor)),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => RegisterWeb()),
                                      ),
                                text: " SIGN UP",
                                style: TextStyle(color: Colors.blue))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
