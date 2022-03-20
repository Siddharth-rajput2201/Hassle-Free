import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hassle_free/screens/Login.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({Key? key}) : super(key: key);

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
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
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // setState(() {
                        //   _usernameEnabled = false;
                        //   _passwordEnabled = false;
                        //   _signUpButtonEnabled = false;
                        // });
                        // await _validatelogin();
                        // setState(() {
                        //   _usernameEnabled = true;
                        //   _passwordEnabled = true;
                        //   _signUpButtonEnabled = true;
                        // });
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
                              "GO BACK",
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
