import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hassle_free/screens/SplashScreen.dart';
import 'package:hassle_free/screensweb/SplashScreenWeb.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenDecider(),
    );
  }
}

class SplashScreenDecider extends StatefulWidget {
  const SplashScreenDecider({Key? key}) : super(key: key);

  @override
  State<SplashScreenDecider> createState() => _SplashScreenDeciderState();
}

class _SplashScreenDeciderState extends State<SplashScreenDecider> {
  // static int mobileLimit = 640;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constaints) {
        if (kIsWeb) {
            return SplashScreenWeb();
        } else {
          return SplashScreen();
        }
      },
    );
  }
}
