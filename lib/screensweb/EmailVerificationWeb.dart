import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassle_free/Networking/NetworkingWeb.dart';
import 'package:hassle_free/screensweb/LoginWeb.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class EmailVerificationWeb extends StatefulWidget {
  const EmailVerificationWeb({Key? key}) : super(key: key);

  @override
  State<EmailVerificationWeb> createState() => _EmailVerificationWebState();
}

class _EmailVerificationWebState extends State<EmailVerificationWeb> {
  static int mobileLimit = 640;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constaints) {
        if (constaints.maxWidth <= mobileLimit) {
          return EmailVerificationWebView(
              maxWidth: constaints.maxWidth, maxHeight: constaints.maxHeight);
        } else {
          return EmailVerificationWebView(
            maxWidth: constaints.maxWidth / 2.85,
            maxHeight: constaints.maxHeight,
          );
        }
      },
    );
  }
}

class EmailVerificationWebView extends StatefulWidget {
  const EmailVerificationWebView(
      {required this.maxHeight, required this.maxWidth, Key? key})
      : super(key: key);
  final double maxWidth;
  final double maxHeight;
  @override
  State<EmailVerificationWebView> createState() =>
      _EmailVerificationWebViewState();
}

class _EmailVerificationWebViewState extends State<EmailVerificationWebView> {
  bool _showResendEmailButton = true;
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeColors.kBackGroundColor,
        body: Padding(
          padding:
              const EdgeInsets.only(left: 20.0, right: 20, top: 20, bottom: 20),
          child: SizedBox(
            height: height * 0.95,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                  height: widget.maxHeight * 0.55,
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
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SvgPicture.asset(
                        'assets/email.svg',
                        height: widget.maxHeight * 0.25,
                        width: widget.maxWidth * 0.25,
                      ),
                      Center(
                        child: Text(
                          "VERIFY YOUR EMAIL",
                          style: TextStyle(
                            fontSize: height * 0.045,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFF747474),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: width <= 640 ?  MainAxisAlignment.spaceEvenly: MainAxisAlignment.center,
                  children: [
                    _showResendEmailButton
                        ? Container(
                            height: widget.maxHeight * 0.085,
                            width: widget.maxWidth * 0.40,
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
                                    _showResendEmailButton = false;
                                  });
                                  await NetworkWeb.resendemail(context);
                                  setState(() {
                                    _showResendEmailButton = true;
                                  });
                                },
                                child: Center(
                                  child: Text(
                                    "RESEND EMAIL",
                                    style: TextStyle(
                                        fontSize: widget.maxHeight * 0.025,
                                        color: ThemeColors.kTextColor),
                                  ),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: widget.maxHeight * 0.085,
                            width: widget.maxWidth * 0.40,
                            decoration: BoxDecoration(
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
                            child: Center(
                              child: Text(
                                "RESEND EMAIL",
                                style: TextStyle(
                                    fontSize: widget.maxHeight * 0.025,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                   width <= 640 ? SizedBox() 
                    :SizedBox(
                      width: widget.maxWidth * 0.2),
                    Container(
                      height: widget.maxHeight * 0.085,
                      width: widget.maxWidth * 0.40,
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
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginWeb()),
                            );
                          },
                          child: Center(
                            child: Text(
                              "LOGIN",
                              style: TextStyle(
                                  fontSize: height * 0.025,
                                  color: ThemeColors.kTextColor),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
