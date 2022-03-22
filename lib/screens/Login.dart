import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/UserPass.dart';
import 'package:hassle_free/screens/Register.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/ThemeColors.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController userNameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  LocalAuthentication authentication = LocalAuthentication();
  bool _usernameEnabled = true;
  bool _passwordEnabled = true;
  bool _signUpButtonEnabled = true;
  bool _showPasswordEnabled = true;
  final formGlobalKey = GlobalKey<FormState>();

  bool ?_hasBiometricSensor ;
  
  Future<void> _checkBio() async {
    try {
      _hasBiometricSensor = await authentication.isDeviceSupported();
      if (_hasBiometricSensor!) {
        _getAuth();
      }
    } catch (e) {
      
    }
  }

  Future<void> _getAuth() async {
    bool? isAuth = false;
    try {
      isAuth = await authentication.authenticate(
        localizedReason: "HASSLE FREE",
        stickyAuth: true,
        useErrorDialogs: true,
        androidAuthStrings: AndroidAuthMessages(
          goToSettingsButton: goToSettings
          ),
        sensitiveTransaction: true
      );
      if(isAuth)
      {
         Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserPass()));
      }
      else{
        _getAuth();
      }
    } on PlatformException catch (e) {
      if(e.code == auth_error.notAvailable)
      {
        customSnackBar(context, "We recommend to use fingerprint", Colors.orange);
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => UserPass()));
      }
    }
    
  }

  void _redirect() async {
    if (await Network.auth(context)) {
      _checkBio();
      // Navigator.pushReplacement(
      //     context, MaterialPageRoute(builder: (context) => UserPass()));
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    }
  }

  Future _validatelogin() async {
    if (formGlobalKey.currentState!.validate() == true) {
      if (await Network.login(userNameController.text.trim(),
          passwordController.text.trim(), context)) {
       _redirect();
      }
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
                      SizedBox(
                        height: height * 0.525,
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
                              height: height * 0.35,
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
                                              color:
                                                  ThemeColors.kBackGroundColor),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ThemeColors.kBackGroundColor),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        prefixIcon:
                                            Icon(Icons.person_outline_outlined),
                                        hintText: "USERNAME",
                                        hintStyle:
                                            TextStyle(fontSize: height * 0.025),
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
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                                  ThemeColors.kBackGroundColor),
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                        ),
                                        hintText: "PASSWORD",
                                        hintStyle:
                                            TextStyle(fontSize: height * 0.025),
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
                                ? GestureDetector(
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
                                    child: Container(
                                      // duration: Duration(milliseconds: 500),
                                      height: height * 0.085,
                                      width: width,
                                      decoration: BoxDecoration(
                                        color: ThemeColors.kBackGroundColor,
                                        borderRadius: BorderRadius.circular(30),
                                        // gradient: LinearGradient(
                                        //   colors: [
                                        //   // Colors.blue[300]!,
                                        //   // Colors.blue[200]!,
                                        //     // Color.fromARGB(255, 189, 204, 230),
                                        //     // Color.fromARGB(255, 214, 230, 255)
                                        //     // Color(0xFFf7f5ec)
                                        //   ],
                                        //   begin: Alignment.topCenter,
                                        //   end: Alignment.bottomCenter,
                                        //   stops: [0.0, 0.4],
                                        //   tileMode: TileMode.clamp,
                                        // ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: ThemeColors.kDarkShadowColor,
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
                                        "LOGIN",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500,
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
                                        fontSize: height * 0.025,
                                        color: Colors.blue,
                                      ),
                                    )),
                                  )
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
                                            builder: (context) => Register()),
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
