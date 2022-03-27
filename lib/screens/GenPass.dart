import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/GenerateRandomPass.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class GenPass extends StatefulWidget {
  const GenPass({Key? key}) : super(key: key);

  @override
  State<GenPass> createState() => _GenPassState();
}

class _GenPassState extends State<GenPass> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Container(
          height: height * 0.5,
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
          padding: EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Text(
                    "Generate Strong Random Password",
                    style: TextStyle(
                        fontSize: width * 0.045, fontWeight: FontWeight.bold,color: ThemeColors.kTextColor),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
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
                child: TextFormField(
                  controller: _controller,
                  readOnly: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ThemeColors.kBackGroundColor),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          BorderSide(color: ThemeColors.kBackGroundColor),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          final data = ClipboardData(text: _controller.text);
                          Clipboard.setData(data);

                          customSnackBar(
                              context, "PASSWORD COPIED", Colors.green);
                        },
                        icon: Icon(Icons.copy)),
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
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                height: height * 0.085,
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
                  type: MaterialType.transparency,
                  color: ThemeColors.kBackGroundColor,
                  child: InkWell(
                    highlightColor: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    onTap: () {
                      final password = generatePassword();
                      _controller.text = password;
                    },
                    child: Center(
                      child: Text(
                        "GENERATE PASSWORD",
                        style: TextStyle(
                            fontSize: height * 0.025,
                            color: ThemeColors.kTextColor),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // Widget buildButtonWidget() {
  //   return Container(
  //                     height: height * 0.085,
  //                     width: width * 0.40,
  //                     decoration: BoxDecoration(
  //                       color: ThemeColors.kBackGroundColor,
  //                       borderRadius: BorderRadius.circular(30),
  //                       boxShadow: [
  //                         BoxShadow(
  //                           color: ThemeColors.kDarkShadowColor,
  //                           offset: Offset(4, 4),
  //                           blurRadius: 15,
  //                           spreadRadius: 1,
  //                         ),
  //                         BoxShadow(
  //                           color: ThemeColors.kLightShadowColor,
  //                           offset: Offset(-4, -4),
  //                           blurRadius: 15,
  //                           spreadRadius: 1,
  //                         )
  //                       ],
  //                     ),
  //                     child: Material(
  //                       borderRadius: BorderRadius.circular(30),
  //                       type: MaterialType.transparency,
  //                       color: ThemeColors.kBackGroundColor,
  //                       child: InkWell(
  //                         highlightColor: Colors.transparent,
  //                         borderRadius: BorderRadius.circular(30),
  //                         onTap: () {
  //                           Navigator.pushReplacement(
  //                             context,
  //                             MaterialPageRoute(builder: (context) => Login()),
  //                           );
  //                         },
  //                         child: Center(
  //                           child: Text(
  //                             "LOGIN",
  //                             style: TextStyle(
  //                                 fontSize: height * 0.025,
  //                                 color: ThemeColors.kTextColor),
  //                           ),
  //                         ),
  //                       ),
  //                     ),
  //                   );
  //   // ElevatedButton(
  //   //     style: ElevatedButton.styleFrom(primary: Colors.black),
  //   //     onPressed: () {
  //   //       final password = generatePassword();
  //   //       _controller.text = password;
  //   //     },
  //   //     child: Text(
  //   //       "Password Generate",
  //   //       style: TextStyle(color: Colors.white),
  //   //     ));
  // }
}
