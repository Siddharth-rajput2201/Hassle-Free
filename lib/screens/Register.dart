import 'dart:developer';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  bool _usernameEnabled = true;
  bool _passwordEnabled = true;
  bool _confirmPasswordEnabled = true;
  bool _loginButtonEnabled = true;
  bool _showPasswordEnabled = true;
  bool _showConfirmPasswordEnabled = true;
  final formGlobalKey = GlobalKey<FormState>();
  Future _validatelogin() async {
    if (formGlobalKey.currentState!.validate() == true) {
      log("REGISTERED");
      if (await Network.register(userNameController.text.trim(),
          confirmPasswordController.text.trim(), context)) {}
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
                      SizedBox(
                        height: height * 0.55,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                            TextFormField(
                              enabled: _usernameEnabled,
                              controller: userNameController,
                              decoration: InputDecoration(
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
                            TextFormField(
                              enabled: _passwordEnabled,
                              controller: passwordController,
                              obscureText: _showPasswordEnabled,
                              decoration: InputDecoration(
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
                            TextFormField(
                              enabled: _confirmPasswordEnabled,
                              controller: confirmPasswordController,
                              obscureText: _showConfirmPasswordEnabled,
                              decoration: InputDecoration(
                                hintText: "CONFIRM PASSWORD",
                                hintStyle: TextStyle(fontSize: height * 0.025),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(25.0),
                                ),
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: InkWell(
                                  child: Icon(_showConfirmPasswordEnabled
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  onTap: () {
                                    setState(() {
                                      if (_showConfirmPasswordEnabled == true) {
                                        _showConfirmPasswordEnabled = false;
                                      } else {
                                        _showConfirmPasswordEnabled = true;
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
                            _loginButtonEnabled
                                ? ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        _usernameEnabled = false;
                                        _passwordEnabled = false;
                                        _loginButtonEnabled = false;
                                        _confirmPasswordEnabled = false;
                                      });
                                      await _validatelogin();
                                      setState(() {
                                        _usernameEnabled = true;
                                        _passwordEnabled = true;
                                        _loginButtonEnabled = true;
                                        _confirmPasswordEnabled = true;
                                      });
                                    },
                                    child: Text(
                                      "SIGN UP",
                                      style:
                                          TextStyle(fontSize: height * 0.025),
                                    ),
                                    style: ButtonStyle(
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(width, height * 0.085)),
                                      backgroundColor:
                                          MaterialStateProperty.all<Color>(
                                              Color(0xffe4717d)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          // side: BorderSide(color: Colors.red),
                                        ),
                                      ),
                                    ),
                                  )
                                : ElevatedButton(
                                    onPressed: null,
                                    child: Text(
                                      "SIGN UP",
                                      style:
                                          TextStyle(fontSize: height * 0.025),
                                    ),
                                    style: ButtonStyle(
                                      fixedSize:
                                          MaterialStateProperty.all<Size>(
                                              Size(width, height * 0.085)),
                                      shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          // side: BorderSide(color: Colors.red),
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
