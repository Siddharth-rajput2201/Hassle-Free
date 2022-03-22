import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hassle_free/Networking/Network.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class EmailVerificationRegister extends StatefulWidget {
  EmailVerificationRegister({Key? key,required this.emailid}) : super(key: key);
  final String emailid;
  @override
  State<EmailVerificationRegister> createState() => _EmailVerificationRegisterState();
}

class _EmailVerificationRegisterState extends State<EmailVerificationRegister> {
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
                  height: height * 0.55,
                  width: width,
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
                        height: height * 0.25,
                        width: width * 0.25,
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
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Center(
                          child: Text(
                            widget.emailid,
                            style: TextStyle(
                              fontSize: height * 0.030,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF747474),
                            ),
                          ),
                      ),
                        ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                  _showResendEmailButton ? GestureDetector(
                            onTap: () async {
                              setState(() {
                                _showResendEmailButton = false;
                              });
                              await Network.resendemail(context);
                              setState(() {
                                _showResendEmailButton = true;
                              });
                            },
                            child: Container(
                              height: height * 0.085,
                              width: width * 0.40,
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
                              child: Center(
                                child: Text(
                                  "RESEND EMAIL",
                                  style: TextStyle(
                                      fontSize: height * 0.025,
                                      color: ThemeColors.kTextColor),
                                ),
                              ),
                            ),
                          )
                        : Container(
                            height: height * 0.085,
                            width: width * 0.40,
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
                                    fontSize: height * 0.025,
                                    color: Colors.blue),
                              ),
                            ),
                          ),
                    Container(
                      height: height * 0.085,
                      width: width * 0.40,
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
                          splashColor: Colors.blue[200],
                          highlightColor: Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                          onTap: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
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