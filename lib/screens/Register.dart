import 'dart:developer';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _usernameEnabled = true;
  bool _emailEnabled = true;
  bool _passwordEnabled = true;
  bool _confirmPasswordEnabled = true;
  bool _loginButtonEnabled = true;
  bool _showPasswordEnabled = true;
  bool _showConfirmPasswordEnabled = true;
  RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$");
  RegExp specialCharRegex =
      RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  RegExp upperCaseRegex = RegExp(r'[A-Z]');
  RegExp lowerCaseRegex = RegExp(r'[a-z]');
  RegExp numberRegex = RegExp(r'[0-9]');
  final formGlobalKey = GlobalKey<FormState>();
  Future _validatelogin() async {
    if (formGlobalKey.currentState!.validate() == true) {
      log("REGISTERED");
      if (await Network.register(
          userNameController.text.trim(),
          confirmPasswordController.text.trim(),
          emailController.text.trim(),
          context)) {}
    }
  }

  @override
  void initState() {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
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
                  height: height * 0.9,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: height * 0.775,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Container(
                                  height: height * 0.6,
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
                                  padding: EdgeInsets.only(
                                    left: 10,
                                    right: 10,
                                    bottom: 7,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Center(
                                        child: Text(
                                          "Sign Up",
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
                                                  color: ThemeColors
                                                      .kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ThemeColors
                                                      .kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            prefixIcon: Icon(
                                                Icons.person_outline_outlined),
                                            hintText: "USERNAME",
                                            hintStyle: TextStyle(
                                                fontSize: height * 0.025),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                          ),
                                          validator: (valUsername) {
                                            if (valUsername!.isEmpty) {
                                              return "USERNAME CANNOT BE EMPTY";
                                            }
                                            if (valUsername.contains(" ") ==
                                                true) {
                                              return "USERNAME SHOULD NOT CONTAIN SPACE";
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
                                          enabled: _emailEnabled,
                                          controller: emailController,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ThemeColors
                                                      .kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ThemeColors
                                                      .kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            prefixIcon:
                                                Icon(Icons.email_outlined),
                                            hintText: "EMAIL",
                                            hintStyle: TextStyle(
                                                fontSize: height * 0.025),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                          ),
                                          validator: (valEmail) {
                                            if (valEmail!.isEmpty) {
                                              return "EMAIL CANNOT BE EMPTY";
                                            }
                                            if (!emailRegex
                                                .hasMatch(valEmail.trim())) {
                                              return "NOT A VALID EMAIL";
                                            }
                                             else {
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
                                                  color: ThemeColors
                                                      .kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ThemeColors
                                                      .kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            hintText: "PASSWORD",
                                            hintStyle: TextStyle(
                                                fontSize: height * 0.025),
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
                                                    _showPasswordEnabled =
                                                        false;
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
                                            }
                                            if (!specialCharRegex
                                                .hasMatch(valPassword.trim())) {
                                              return "SPECIAL CHARACTER MISSING";
                                            }
                                              if (!upperCaseRegex
                                                .hasMatch(valPassword.trim())) {
                                              return "UPPERCASE MISSING";
                                            }
                                            if (!lowerCaseRegex
                                                .hasMatch(valPassword.trim())) {
                                              return "LOWERCASE MISSING";
                                            }
                                            if (!numberRegex
                                                .hasMatch(valPassword.trim())) {
                                              return "NUMBER MISSING";
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
                                          enabled: _confirmPasswordEnabled,
                                          controller: confirmPasswordController,
                                          obscureText:
                                              _showConfirmPasswordEnabled,
                                          decoration: InputDecoration(
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ThemeColors
                                                      .kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ThemeColors
                                                      .kBackGroundColor),
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            hintText: "CONFIRM PASSWORD",
                                            hintStyle: TextStyle(
                                                fontSize: height * 0.025),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(25.0),
                                            ),
                                            prefixIcon: Icon(Icons.lock),
                                            suffixIcon: InkWell(
                                              child: Icon(
                                                  _showConfirmPasswordEnabled
                                                      ? Icons.visibility
                                                      : Icons.visibility_off),
                                              onTap: () {
                                                setState(() {
                                                  if (_showConfirmPasswordEnabled ==
                                                      true) {
                                                    _showConfirmPasswordEnabled =
                                                        false;
                                                  } else {
                                                    _showConfirmPasswordEnabled =
                                                        true;
                                                  }
                                                });
                                              },
                                            ),
                                          ),
                                          validator: (valConfirmPassword) {
                                            if (valConfirmPassword!.isEmpty) {
                                              return "CONFIRM PASSWORD CANNOT BE EMPTY";
                                            }
                                            if (valConfirmPassword !=
                                                passwordController.text) {
                                              return "PASSWORD DOES NOT MATCHED";
                                            } else {
                                              return null;
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                _loginButtonEnabled
                                    ? GestureDetector(
                                        onTap: () async {
                                          setState(() {
                                            _usernameEnabled = false;
                                            _passwordEnabled = false;
                                            _loginButtonEnabled = false;
                                            _emailEnabled = false;
                                            _confirmPasswordEnabled = false;
                                          });
                                          await _validatelogin();
                                          setState(() {
                                            _usernameEnabled = true;
                                            _passwordEnabled = true;
                                            _loginButtonEnabled = true;
                                            _emailEnabled = true;
                                            _confirmPasswordEnabled = true;
                                          });
                                        },
                                        child: Container(
                                          // duration: Duration(milliseconds: 500),
                                          height: height * 0.085,
                                          width: width,
                                          decoration: BoxDecoration(
                                            color: ThemeColors.kBackGroundColor,
                                            borderRadius:
                                                BorderRadius.circular(30),
                                            boxShadow: [
                                              BoxShadow(
                                                color: ThemeColors
                                                    .kDarkShadowColor,
                                                offset: Offset(4, 4),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                              ),
                                              BoxShadow(
                                                color: ThemeColors
                                                    .kLightShadowColor,
                                                offset: Offset(-4, -4),
                                                blurRadius: 15,
                                                spreadRadius: 1,
                                              )
                                            ],
                                          ),
                                          child: Center(
                                              child: Text(
                                            "SIGN UP",
                                            style: TextStyle(
                                                fontSize: height * 0.025,
                                                color: ThemeColors.kTextColor),
                                          )),
                                        ),
                                      )
                                    : Container(
                                        // duration: Duration(milliseconds: 500),
                                        height: height * 0.085,
                                        width: width,
                                        decoration: BoxDecoration(
                                          color: Color(0xffdee8fc),
                                          borderRadius:
                                              BorderRadius.circular(30),
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
                                              color:
                                                  ThemeColors.kDarkShadowColor,
                                              offset: Offset(4, 4),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            ),
                                            BoxShadow(
                                              color:
                                                  ThemeColors.kLightShadowColor,
                                              offset: Offset(-4, -4),
                                              blurRadius: 15,
                                              spreadRadius: 1,
                                            )
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "SIGN UP",
                                            style: TextStyle(
                                              fontSize: height * 0.025,
                                              color: Colors.blue,
                                            ),
                                          ),
                                        ),
                                      ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                                text: "ALREADY A USER?",
                                style: TextStyle(color: Color(0xFF747474))),
                            TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Login()),
                                      ),
                                text: " LOGIN",
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
