import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hassle_free/utils/CustomSnackBar.dart';
import 'package:hassle_free/utils/GenerateRandomPass.dart';
import 'package:hassle_free/utils/ThemeColors.dart';

class GenPassWeb extends StatefulWidget {
  const GenPassWeb({ Key? key }) : super(key: key);

  @override
  State<GenPassWeb> createState() => _GenPassWebState();
}

class _GenPassWebState extends State<GenPassWeb> {
  static int mobileLimit = 640;
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constaints) {
        if (constaints.maxWidth <= mobileLimit) {
          return GenPassWebView(
              maxWidth: constaints.maxWidth, maxHeight: constaints.maxHeight);
        } else {
          return GenPassWebView(
            maxWidth: constaints.maxWidth / 2.85,
            maxHeight: constaints.maxHeight,
          );
        }
      },
    );
  }
}

class GenPassWebView extends StatefulWidget {
  const GenPassWebView({required this.maxHeight, required this.maxWidth, Key? key }) : super(key: key);
  final double maxWidth;
  final double maxHeight;
  @override
  State<GenPassWebView> createState() => _GenPassWebViewState();
}

class _GenPassWebViewState extends State<GenPassWebView> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    // double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Center(
        child: Container(
          height: height * 0.5,
          width : widget.maxWidth,
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
                        fontSize: widget.maxWidth * 0.045, fontWeight: FontWeight.bold,color: ThemeColors.kTextColor),
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
}