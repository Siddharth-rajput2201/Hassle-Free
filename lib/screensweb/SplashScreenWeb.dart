import 'package:flutter/material.dart';
import 'package:hassle_free/Networking/NetworkingWeb.dart';
import 'package:hassle_free/utils/ThemeColors.dart';



class SplashScreenWeb extends StatefulWidget {
  const SplashScreenWeb({ Key? key }) : super(key: key);

  @override
  State<SplashScreenWeb> createState() => _SplashScreenWebState();
}


class _SplashScreenWebState extends State<SplashScreenWeb> {
  @override
  void initState() {
    NetworkWeb.authweb(context);
    super.initState();
  }
  static int mobileLimit = 640;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constaints) {
        if (constaints.maxWidth <= mobileLimit) {
            return SplashScreenWebView(maxWidth: constaints.maxWidth/1.75, maxHeight: constaints.maxHeight/2.25,);
        } else {
          return SplashScreenWebView(maxWidth: constaints.maxWidth/2.85,maxHeight: constaints.maxHeight/1.75,);
        }
      },
    );
  }
}

class SplashScreenWebView extends StatefulWidget {

  SplashScreenWebView({required this.maxWidth,required this.maxHeight,Key? key}) : super(key: key);
  final double maxWidth;
  final double maxHeight;
  @override
  State<SplashScreenWebView> createState() => _SplashScreenWebViewState();
}

class _SplashScreenWebViewState extends State<SplashScreenWebView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.kBackGroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: widget.maxHeight,
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
                child: Image.asset("assets/Hassle_Free_Logo_Animate.gif")),
          ),
        ),
      ),
    );
  }
}