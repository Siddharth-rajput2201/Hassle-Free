import 'package:flutter/material.dart';
import 'package:hassle_free/utils/Storage.dart';
import 'package:hassle_free/utils/ThemeColors.dart';
import 'package:hassle_free/utilsweb/DialogBoxDeleteAcc.dart';

class DeleteAccountWeb extends StatefulWidget {
  const DeleteAccountWeb({Key? key}) : super(key: key);

  @override
  State<DeleteAccountWeb> createState() => _DeleteAccountWebState();
}

class _DeleteAccountWebState extends State<DeleteAccountWeb> {
  final formGlobalKey = GlobalKey<FormState>();
  TextEditingController userNameController = TextEditingController();
  bool _continueButtonEnabled = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ThemeColors.kBackGroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: ThemeColors.kTextColor),
        title: Text(
          "Delete Account",
          style: TextStyle(color: ThemeColors.kTextColor),
        ),
        elevation: 0.0,
        backgroundColor: ThemeColors.kBackGroundColor,
      ),
      body: SizedBox(
        width: width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
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
              width: width * 0.4,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Once you delete this account.There is no going back.All the data associated with this account and this account will deleted permanently.",
                        style: TextStyle(fontSize: height * 0.028),
                      ),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      FutureBuilder<Object>(
                          future: Storage.getUserName(),
                          builder: (context, snapshot) {
                            return RichText(
                              text: TextSpan(
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Please type ',
                                    style: TextStyle(
                                        fontSize: height * 0.028,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: '"',
                                    style: TextStyle(
                                        fontSize: height * 0.028,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: snapshot.data.toString(),
                                    style: TextStyle(
                                        fontSize: height * 0.028,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  TextSpan(
                                    text: '"',
                                    style: TextStyle(
                                        fontSize: height * 0.028,
                                        color: Colors.black),
                                  ),
                                  TextSpan(
                                    text: ' to confirm.',
                                    style: TextStyle(
                                        fontSize: height * 0.028,
                                        color: Colors.black),
                                  ),
                                ],
                              ),
                            );
                          }),
                      SizedBox(
                        height: height * 0.025,
                      ),
                      Form(
                        key: formGlobalKey,
                        child: Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(25.0)),
                            ),
                          ),
                          child: TextFormField(
                            enabled: true,
                            controller: userNameController,
                            decoration: InputDecoration(
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ThemeColors.kBackGroundColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: ThemeColors.kBackGroundColor),
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              hintText: "USERNAME",
                              hintStyle: TextStyle(fontSize: height * 0.025),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                            ),
                            onChanged: (valUsername) async {
                              if (valUsername == await Storage.getUserName()) {
                                setState(() {
                                  _continueButtonEnabled = true;
                                });
                              } else {
                                setState(() {
                                  _continueButtonEnabled = false;
                                });
                              }
                            },
                            // validator: (valUsername) {
                            //   if (valUsername!.isEmpty) {
                            //     return "USERNAME CANNOT BE EMPTY";
                            //   } else {
                            //     // setState(() {
                            //     //   _loginButtonEnabled = true;
                            //     // });
                            //     return null;
                            //   }
                            // },
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 0.035,
                      ),
                      OutlinedButton(
                        style: ButtonStyle(
                          side: _continueButtonEnabled
                              ? MaterialStateProperty.all<BorderSide>(
                                  BorderSide(color: Colors.red, width: 2))
                              : MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                      color: Colors.grey[400]!, width: 2)),
                          fixedSize: MaterialStateProperty.all<Size>(
                              Size(width, height * 0.085)),
                          foregroundColor: _continueButtonEnabled
                              ? MaterialStateProperty.all<Color>(
                                  Color(0xffe4717d))
                              : MaterialStateProperty.all<Color>(
                                  Colors.grey[400]!),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25.0),
                              // side: BorderSide(color: Colors.red),
                            ),
                          ),
                        ),
                        onPressed: _continueButtonEnabled
                            ? () {
                                showDialog(
                                    context: context,
                                    builder: (builder) {
                                      return Dialog(
                                        backgroundColor:
                                            ThemeColors.kBackGroundColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                        ),
                                        child: DialogBoxDeleteAcc()
                                      );
                                    });
                              }
                            : null,
                        child: Text("Continue",
                            style: TextStyle(fontSize: height * 0.025)),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
