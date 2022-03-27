import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/screens/Home.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/ThemeColors.dart';
import 'package:local_auth/auth_strings.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  LocalAuthentication authentication = LocalAuthentication();
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
          context, MaterialPageRoute(builder: (context) => Home()));
      }
      else{
        _getAuth();
      }
    } on PlatformException catch (e) {
      if(e.code == auth_error.notAvailable)
      {
        log(e.toString());
        customSnackBar(context, "We recommend to use fingerprint", Colors.orange);
          Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Home()));
      }
    }

  }

  @override
  void initState() {
    _redirect();
    super.initState();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kBackGroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                 
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
                  child: Image.asset("assets/Hassle_Free_Logo_Animate.gif")),
            ),
          ],
        ),
      ),
    );
  }
}
